//
//  RepoModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 08/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//
import Mapper

final class RepoModel: Reflectable, Mappable {
    
    var id: Int?
    var name: String?
    var url: String?
    
    required init(map: Mapper) throws {
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        url = map.optionalFrom("url")
    }
}
