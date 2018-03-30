//
//  MainStarter.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 18/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import UIKit

class MainStarter {
    
    func start(viewController: UIViewController, animated: Bool = true, eventModel: EventModel) {
       
    }
}

extension UIViewController {
    class func main() -> MainViewController {
        return UIStoryboard.main()
            .instantiateInitialViewController()?.childViewControllers.first as! MainViewController
    }
}

extension UIStoryboard {
    class func main() -> UIStoryboard {
        return UIStoryboard(name: StoryboardName.Main, bundle: nil)
    }
}
