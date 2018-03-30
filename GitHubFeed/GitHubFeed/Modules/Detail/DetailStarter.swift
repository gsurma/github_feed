//
//  DetailStarter.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 12/10/2017.
//  Copyright © 2017 GS. All rights reserved.
//

import UIKit

class DetailStarter {
	
    func start(viewController: UIViewController, animated: Bool = true, eventModel: EventModel) {
        let detailViewController = UIViewController.detail()
        detailViewController.eventModel = eventModel
        viewController.navigationController?.pushViewController(detailViewController, animated: animated)
    }
}

extension UIViewController {
    class func detail() -> DetailViewController {
        return UIStoryboard.detail()
            .instantiateInitialViewController() as! DetailViewController
    }
}

extension UIStoryboard {
    class func detail() -> UIStoryboard {
        return UIStoryboard(name: StoryboardName.Detail, bundle: nil)
    }
}
