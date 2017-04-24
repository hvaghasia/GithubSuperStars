//
//  Storyboard.swift
//  GithubSuperStars
//
//  Created by Hardik on 24/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation
import UIKit
@testable import GithubSuperStars

// Class to provide instantiated custom viewcontroller
class Storyboard {
    
    class func viewController(fromStoryboard name: String, withViewControllerIdentifier identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: name, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: identifier) as UIViewController
    }
    
    //MARK: Custom View Controllers
    class func projectListViewController() -> ProjectsListViewController {
        return self.viewController(fromStoryboard: Constants.StoryboardType.main,
                                   withViewControllerIdentifier: ProjectsListViewController.reuseIdentifier) as! ProjectsListViewController
    }
    
}
