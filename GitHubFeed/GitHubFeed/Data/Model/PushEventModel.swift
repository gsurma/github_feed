//
//  PushEventModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 08/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class PushEventModel: EventContainerResultModel {
    
    var pushEventPayload: PushEventPayloadModel?
    override var payload: PayloadModel? {
        return pushEventPayload
    }
    
    required init(map: Mapper) throws {
        pushEventPayload = map.optionalFrom("payload")
        try super.init(map: map)
    }
}
