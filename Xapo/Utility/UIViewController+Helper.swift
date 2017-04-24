//
//  UIViewController+Helper.swift
//  GithubSuperStars
//
//  Created by Hardik on 23/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation
import UIKit

typealias AlertDismissCallback = () -> Void

extension UIViewController {
    
    /**
     Display Alert on current view controller
     
     - parameter title:   The title to be displayed on Alert
     - parameter message: The message to be displayed on Alert
     */
    func showAlert(title: String = "",
                   message: String = "",
                   buttonTitle: String = Constants.AlertViewActionButtonTitle.ok,
                   completion: AlertDismissCallback? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (alertAction) in
            completion?()
        }))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
