//
//  MainContract.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import Foundation
import RxSwift

protocol MainContractRouting: ViperRxRouting {
    func startDetailScreen(eventModel: EventModel)
}

protocol MainContractInteractor: ViperRxInteractor {
    func getEvents() -> Observable<[EventModel]>
}

protocol MainContractView: ViperRxView {
    var refreshes: Observable<()> { get }
    var eventsSubject: PublishSubject<[EventModel]> { get }
    var showDetailsSubject: PublishSubject<EventModel> { get }
}
