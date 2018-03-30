//
//  EventMoyaSpecification.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 07/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import RxCocoa
import RxSwift
import Moya
import Moya_ModelMapper

class EventMoyaSpecification: Specification {
    
    let requestType: EventMoyaAPI
    
    init(requestType: EventMoyaAPI) {
        self.requestType = requestType
    }
    
    func getResult(moyaProvider: RxMoyaProvider<EventMoyaAPI>) -> Observable<[EventModel]> {
        return moyaProvider
            .request(requestType)
            .mapArray(type: EventModel.self)
            .map({ (events) -> [EventModel] in
                events.filter { event in event.event != nil }
            })
    }
}
