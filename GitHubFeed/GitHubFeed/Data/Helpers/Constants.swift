//
//  Constants.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 07/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Foundation

typealias StringKeyValue = (String, String)
typealias PropertyWithValue = (String, Any)
typealias PropertiesWithValues = [PropertyWithValue]

struct Main {
    static let navigationBarTitle = "Latest GitHub Events"
}

struct GitHubEndpoint {
    static let host = "https://api.github.com"
    static let path = "/events"
}

struct EventType {
    static let push = "PushEvent"
    static let pullRequest = "PullRequestEvent"
}

struct TabBarEventType {
    static let push = "Push Events"
    static let pullRequest = "Pull Request Events"
}

enum EventListCellType {
    case push(event: EventModel)
    case pullRequest(event: EventModel)
    case noData()
}

struct Cell {
    static let mainEventCellIdentifier = "mainEventCellIdentifier"
    static let mainNoDataCellIdentifier = "mainNoDataCellIdentifier"
}

extension TimeInterval {
    static let refreshEventsTimer = 30.0
    static let throttleButtonDelay = 0.5
}

struct StoryboardName {
    static let Main = "Main"
    static let Detail = "Detail"
}
