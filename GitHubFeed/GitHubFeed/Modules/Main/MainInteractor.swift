//
//  MainInteractor.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class MainInteractor: BaseRxInteractor, MainContractInteractor {

    func getEvents() -> Observable<[EventModel]> {
        return EventMoyaRepository()
            .query(specification: EventMoyaSpecification(requestType: .base))
    }
}
