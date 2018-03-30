//
//  EventMoyaRepository.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 07/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import RxSwift
import Moya

class EventMoyaRepository: RepositoryObservable {

    typealias EntityType = EventModel
    
    private let moyaProvider: RxMoyaProvider<EventMoyaAPI> = RxMoyaProvider()
    
    func query(specification: Specification) -> Observable<[EventModel]> {
        return (specification as! EventMoyaSpecification)
            .getResult(moyaProvider: moyaProvider)
    }
}
