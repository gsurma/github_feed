//
//  MainViewController.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseRxViewController, MainContractView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    let refreshControl = UIRefreshControl()
    
    var eventsSubject: PublishSubject<[EventModel]> = PublishSubject()
    var listingItems: Variable<[EventListCellType]> = Variable<[EventListCellType]>([])
    var filterSubject: BehaviorSubject<String> = BehaviorSubject(value: EventType.push)
    var showDetailsSubject: PublishSubject<EventModel> = PublishSubject()
    
    lazy var refreshes: Observable<()> = {
        return self.refreshControl.rx
            .controlEvent(.valueChanged)
            .map { [weak self] in
                self?.refreshControl.endRefreshing()
            }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.selectedItem = tabBar.items?.first
        navigationItem.title = Main.navigationBarTitle
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        setUpSubscriptions()
    }
    
    func setUpSubscriptions() {
        addSubscription(subscription:
            Observable
                .combineLatest(eventsSubject, filterSubject,
                               resultSelector: { events, filter in
                                return (events, filter)
                })
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                .map { events, filter  -> [EventModel] in
                    if !filter.isEmpty {
                        return events.filter { event in
                            event.type == filter
                        }
                    }
                    return events
                }
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                .map { [weak self] (events) -> [EventListCellType] in
                    self?.createEventsList(events: events) ?? []
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] (listingItems) in
                    self?.displayOnList(items: listingItems)
                })
        )
        
        addSubscription(subscription:
            listingItems
                .asObservable()
                .bind(to: tableView.rx.items) { [weak self] in
                    self?.getCellFor(type: $2, tableView: $0) ?? UITableViewCell()
            }
        )
    }
    
    func createEventsList(events: [EventModel]) -> [EventListCellType] {
        var eventListCellTypes = [EventListCellType]()
        for event in events {
            if event.type == EventType.push {
                eventListCellTypes
                    .append(EventListCellType.push(event: event))
            } else if event.type == EventType.pullRequest {
                eventListCellTypes
                    .append(EventListCellType.pullRequest(event: event))
            }
        }
        return eventListCellTypes.isEmpty ? [EventListCellType.noData()] : eventListCellTypes
    }
    
    private func getCellFor(type: EventListCellType, tableView: UITableView) -> UITableViewCell {
        switch type {
        case .pullRequest(let eventModel), .push(let eventModel):
            let eventCell = tableView.dequeueReusableCell(withIdentifier: Cell.mainEventCellIdentifier) as! MainEventCell
            eventCell.bind(eventModel: eventModel)
            return eventCell
        case .noData:
            return tableView.dequeueReusableCell(withIdentifier: Cell.mainNoDataCellIdentifier) as! MainNoDataCell
        }
    }

    private func displayOnList(items: [EventListCellType]) {
        tableView.isHidden = false
        spinner.isHidden = true
        listingItems.value = items
    }
    
    fileprivate func getEventModelFor(index: Int) -> EventModel? {
        guard listingItems.value.count > index else {
            return nil
        }
        switch listingItems.value[index] {
        case .pullRequest(let eventModel), .push(let eventModel):
           return eventModel
        case .noData:
            return nil
        }
    }

    fileprivate func getEventTypeForTabBarItem(item: UITabBarItem) -> String? {
        if let itemTitle = item.title as String! {
            switch itemTitle {
            case TabBarEventType.push:
                return EventType.push
            case TabBarEventType.pullRequest:
                return EventType.pullRequest
            default:
                break
            }
        }
        return nil
    }

    override func createPresenters() -> [ViperRxPresenter] {
        return [MainPresenter<MainInteractor, MainRouting, MainViewController>()]
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if getEventModelFor(index: indexPath.row) != nil {
            return indexPath
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let eventModelForIndex = getEventModelFor(index: indexPath.row) as EventModel! {
            showDetailsSubject.onNext(eventModelForIndex)
        }
    }
}

extension MainViewController: UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let filter = getEventTypeForTabBarItem(item: item) as String! {
            filterSubject.onNext(filter)
        }
    }
}
