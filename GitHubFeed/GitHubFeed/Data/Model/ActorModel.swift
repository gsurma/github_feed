//
//  ActorModel.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 08/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Mapper

final class ActorModel: Reflectable, Mappable {
    
    var avatar_url: String?
    var display_login: String?
    var id: Int?
    var login: String?
    var url: String?
    
    required init(map: Mapper) throws {
        avatar_url = map.optionalFrom("avatar_url")
        display_login = map.optionalFrom("display_login")
        id = map.optionalFrom("id")
        login = map.optionalFrom("login")
        url = map.optionalFrom("url")
    }
}
