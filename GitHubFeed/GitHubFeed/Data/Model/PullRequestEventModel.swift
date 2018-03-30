//
//  PullRequestEventModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 08/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class PullRequestEventModel: EventContainerResultModel {
    
    var PullRequestEventPayload: PullRequestEventPayloadModel?
    override var payload: PayloadModel? {
        return PullRequestEventPayload
    }
    
    required init(map: Mapper) throws {
        PullRequestEventPayload = map.optionalFrom("payload")
        try super.init(map: map)
    }
}
