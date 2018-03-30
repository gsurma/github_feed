//
//  MainPresenter.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import UIKit
import RxSwift

class MainPresenter
     <InteractorType: MainContractInteractor, RoutingType: MainContractRouting, ViewType: MainContractView>
    : BaseRxPresenter<InteractorType, RoutingType, ViewType> {

    var refreshEventsTimer: Timer!
    let refreshEventsSubject = PublishSubject<()>()
    
    override func attach(viperView: ViperRxView) {
        super.attach(viperView: viperView)
        
        addSubscription(subscription:
            view?
                .showDetailsSubject
                .throttle(.throttleButtonDelay, latest: false, scheduler: MainScheduler.instance)
                .subscribe(onNext: { (eventModel) in
                    self.routing.startDetailScreen(eventModel: eventModel)
            })
        )
        
        addSubscription(subscription:
            self.view?
                .refreshes
                .subscribe(refreshEventsSubject)
        )
        
        addSubscription(subscription:
            refreshEventsSubject
                .subscribe({ [weak self] _ in
                self?.refreshEvents()
            })
        )

        refreshEventsTimer = Timer.scheduledTimer(timeInterval: .refreshEventsTimer,
                                                    target: self,
                                                    selector: #selector(refreshEvents),
                                                    userInfo: nil,
                                                    repeats: true)
        refreshEventsSubject.onNext()
    }
    
    @objc private func refreshEvents() {
        addSubscription(subscription:
            interactor
                .getEvents()
                .subscribe(onNext: { [weak self] events in
                    self?.view?.eventsSubject.onNext(events)
                }, onError: { [weak self] _ in
                    self?.view?.eventsSubject.onNext([])
                })
        )
    }

    override func createRouting() -> RoutingType {
        return MainRouting() as! RoutingType
    }

    override func createInteractor() -> InteractorType {
        return MainInteractor() as! InteractorType
    }
}
