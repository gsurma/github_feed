//
//  CommitModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 10/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class CommitModel: Reflectable, Mappable {
    
    var sha: String?
    var message: String?
    var url: String?
    var distinct: Bool?
    var author: AuthorModel?
    
    required init(map: Mapper) throws {
        sha = map.optionalFrom("sha")
        message = map.optionalFrom("message")
        url = map.optionalFrom("url")
        distinct = map.optionalFrom("distinct")
        author = map.optionalFrom("author")
    }
}
