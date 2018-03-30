//
//  MainPresenterTests.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import XCTest
import Cuckoo
import RxSwift
@testable import GitHubFeed

final class MainPresenterTest: XCTestCase {

    fileprivate var routing: MockMainRouting! = MockMainRouting()
    fileprivate var interactor: MockMainInteractor! = MockMainInteractor()
    fileprivate var view: MockMainViewController! = MockMainViewController().spy(on: UIViewController.main())

    fileprivate var presenter: MainPresenter<MockMainInteractor, MockMainRouting, MockMainViewController>!
    
    override func setUp() {
        super.setUp()
    
        stub(interactor) { stub in
            when(stub.getEvents())
                .thenReturn(Observable.just([EventModel]()))
        }
        
        stub(routing) { stub in
            when(stub.startDetailScreen(eventModel: ParameterMatcher()))
                .thenDoNothing()
        }
        
        presenter = MainPresenter(routing: routing, interactor: interactor)
        presenter.attach(viperView: view)
    }

    func testAttachViewFetchesEvents() {
        verify(interactor).getEvents()
    }
    
    func testInvokeRefreshEventsSubjectFetchesEvents() {
        presenter.refreshEventsSubject.onNext()
        verify(interactor, times(2)).getEvents()
    }
    
    func testRefreshEventsTimerSubjectFetchesEvents() {
        presenter.refreshEventsTimer.fire()
        verify(interactor, times(2)).getEvents()
    }
    
    func testInvokeShowDetailsSubjectGoesToDetailScreen() {
        view.showDetailsSubject.onNext(EventModel())
        verify(routing).startDetailScreen(eventModel: ParameterMatcher())
    }
}
