//
//  BaseRxRouter.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.

import Foundation
import UIKit

class BaseRxRouting: ViperRxRouting {
    init() { }
    weak var viewController: UIViewController?

    func attach(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func detach() {
        self.viewController = nil
    }
}
