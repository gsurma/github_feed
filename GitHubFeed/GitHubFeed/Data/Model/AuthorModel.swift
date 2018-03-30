//
//  AuthorModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 10/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class AuthorModel: Reflectable, Mappable {
    
    var name: String?
    var email: String?
    var username: String?
    
    required init(map: Mapper) throws {
        name = map.optionalFrom("name")
        email = map.optionalFrom("email")
        username = map.optionalFrom("username")
    }
}
