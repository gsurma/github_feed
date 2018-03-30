//
//  EventContainerResultModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 08/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

class EventContainerResultModel: EventModel {
    
    var actor: ActorModel?
    var repo: RepoModel?
    public private(set) var payload: PayloadModel?
    var created_at: String?
    var id: String?
    var is_public: Bool?
    
    required init(map: Mapper) throws {
        actor = map.optionalFrom("actor")
        repo = map.optionalFrom("repo")
        created_at = map.optionalFrom("created_at")
        id = map.optionalFrom("id")
        is_public = map.optionalFrom("public")
        super.init()
    }
}
