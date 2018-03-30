//
//  MainRouting.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 06/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import UIKit

class MainRouting: BaseRxRouting, MainContractRouting {

    var detailStarter: DetailStarter = DetailStarter()
    
    convenience init(detailStarter: DetailStarter) {
        self.init()
        self.detailStarter = detailStarter
    }
    
    func startDetailScreen(eventModel: EventModel) {
        if let viewController = viewController {
            detailStarter
                .start(viewController: viewController,
                       eventModel: eventModel)
        }
    }
}
