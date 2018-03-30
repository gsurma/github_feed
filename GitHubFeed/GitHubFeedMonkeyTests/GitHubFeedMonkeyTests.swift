//
//  GitHubFeedMonkeyTests.swift
//  GitHubFeedMonkeyTests
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import XCTest
import SwiftMonkey

class GitHubFeedMonkeyTests: XCTestCase {
    
    var application = XCUIApplication()
    
    override func setUp() {
        super.setUp()

        application.launch()
    }

    func testMonkey() {
        _ = application.descendants(matching: .any).element(boundBy: 0).frame
        let monkey = Monkey(frame: application.frame)
        monkey.addDefaultUIAutomationActions()
        monkey.addXCTestTapAlertAction(interval: 100, application: application)
        monkey.monkeyAround(iterations: 500)
    }
}
