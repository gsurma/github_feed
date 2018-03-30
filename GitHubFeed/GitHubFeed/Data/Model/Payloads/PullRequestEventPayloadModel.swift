//
//  PullRequestEventPayloadModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 08/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class PullRequestEventPayloadModel: PayloadModel {
    
    var action: String?
    var number: Int?
    var pull_request: PullRequestModel?
    
    required init(map: Mapper) throws {
        try super.init(map: map)
        action = map.optionalFrom("action")
        number = map.optionalFrom("number")
        pull_request = map.optionalFrom("pull_request")
    }
}
