//
//  BaseRxPresenter.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import Foundation

protocol ViperRxPresenter {
    var name: String { get }
    var identifier: String { get }
    func attach(viperView: ViperRxView)
    func detach()
}
