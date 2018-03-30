//
//  MainRoutingTests.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import XCTest
import Cuckoo
@testable import GitHubFeed

final class MainRoutingTests: XCTestCase {

    private var routing: MainRouting!
    private var detailStarter = MockDetailStarter()

	override func setUp() {
		super.setUp()

        let viewController = UIViewController()
        routing = MainRouting(detailStarter: detailStarter)
        _ = UINavigationController(rootViewController: viewController)
        routing.attach(viewController: viewController)
        
        when(detailStarter.getStubbingProxy()
            .start(viewController: ParameterMatcher(),
                   animated: ParameterMatcher(), eventModel: ParameterMatcher()))
            .thenDoNothing()
    }

    func testStartDetailScreen() {
        routing.startDetailScreen(eventModel: EventModel())
        verify(detailStarter)
            .start(viewController: ParameterMatcher(),
                   animated: ParameterMatcher(), eventModel: ParameterMatcher())
    }
}
