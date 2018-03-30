//
//  EventMoyaAPI.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 07/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Moya

enum EventMoyaAPI {
    case base
}

extension EventMoyaAPI: TargetType {
    
    var task: Task {
        return .request
    }
    
    public var baseURL: URL {
        return URL(string: GitHubEndpoint.host) ?? URL(fileURLWithPath: GitHubEndpoint.host)
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var parameters: [String: Any]? {
        return nil
    }
    
    public var path: String {
        return GitHubEndpoint.path
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var validate: Bool {
        return false
    }
}
