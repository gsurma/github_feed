//
//  BaseRxPresenter.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.

import Foundation
import UIKit
import RxSwift

class BaseRxPresenter
    <InteractorType: ViperRxInteractor, RoutingType: ViperRxRouting, ViewType: ViperRxView>
: BaseRx, ViperRxPresenter {

    var interactor: InteractorType!
    var routing: RoutingType!
    weak var view: ViewType?

    let name = DEFAULT_NAME
    let identifier: String = UUID().uuidString
    
    override init() {
        super.init()
        self.routing = createRouting()
        self.interactor = createInteractor()
    }

    init(routing: RoutingType, interactor: InteractorType) {
        self.routing = routing
        self.interactor = interactor
    }

    func attach(viperView: ViperRxView) {
        self.view = viperView as? ViewType
        routing.attach(viewController: view as? BaseRxViewController)
        interactor.attach()
        Moviper.sharedInstance.register(presenter: self)
        if compositeDisposable.isDisposed {
            compositeDisposable = CompositeDisposable()
        }
    }

    func detach() {
        compositeDisposable.dispose()
        Moviper.sharedInstance.unregister(presenter: self)
        interactor.detach()
        routing.detach()
    }
    
    func createRouting() -> RoutingType {
        preconditionFailure("This method must be overridden")
    }

    func createInteractor() -> InteractorType {
        preconditionFailure("This method must be overridden")
    }
}
