//
//  PushEventPayloadModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 08/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class PushEventPayloadModel: PayloadModel {
    
    var ref: String?
    var before: String?
    var head: String?
    var size: Int?
    var distinct_size: Int?
    var commits: [CommitModel]?
    
    required init(map: Mapper) throws {
        try super.init(map: map)
        ref = map.optionalFrom("ref")
        before = map.optionalFrom("before")
        head = map.optionalFrom("head")
        size = map.optionalFrom("size")
        distinct_size = map.optionalFrom("distinct_size")
        commits = map.optionalFrom("commits")
    }
}
