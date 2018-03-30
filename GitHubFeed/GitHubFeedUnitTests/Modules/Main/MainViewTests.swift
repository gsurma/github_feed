//
//  MainViewTests.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
@testable import GitHubFeed

final class MainViewTests: XCTestCase {

	fileprivate var view: MainViewController!

    override func setUp() {
        super.setUp()
        view = UIViewController.main()
        view.loadView()
    }
    
    func testRefreshControlEmitsEvents() {
        let events = view.refreshes
        let testObserver = TestScheduler(initialClock: 0).createObserver(Void.self)
        XCTAssert(testObserver.events.count == 0)
        _ = events.subscribe(testObserver)
        view?.refreshControl.sendActions(for: UIControlEvents.valueChanged)
        XCTAssert(testObserver.events.count == 1)
    }
}
