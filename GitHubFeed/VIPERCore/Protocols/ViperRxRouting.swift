//
//  BaseRxRoutingInterface.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import Foundation
import UIKit

protocol ViperRxRouting {
    func attach(viewController: UIViewController?)
    func detach()
}
