//
//  DetailPresenter.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 12/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import UIKit

class DetailPresenter
     <InteractorType: DetailContractInteractor, RoutingType: DetailContractRouting, ViewType: DetailContractView>
    : BaseRxPresenter<InteractorType, RoutingType, ViewType> {

    override func attach(viperView: ViperRxView) {
        super.attach(viperView: viperView)
    }

    override func createRouting() -> RoutingType {
        return DetailRouting() as! RoutingType
    }

    override func createInteractor() -> InteractorType {
        return DetailInteractor() as! InteractorType
    }
}
