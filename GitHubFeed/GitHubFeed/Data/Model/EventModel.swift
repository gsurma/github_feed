//
//  EventModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 07/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

class EventModel: Reflectable, Mappable {
    
    var event: EventContainerResultModel?
    var type: String?
    
    override init() { }
    required init(map: Mapper) throws {
        type = map.optionalFrom("type")
        if type == EventType.push {
            event = try PushEventModel.init(map: map)
        } else if type == EventType.pullRequest {
            event = try PullRequestEventModel.init(map: map)
        } 
    }
}
