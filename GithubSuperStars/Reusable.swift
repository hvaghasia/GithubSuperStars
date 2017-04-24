//
//  Reusable.swift
//  GithubSuperStars
//
//  Created by Hardik on 19/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: class {}
extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: Reusable {}
extension UIViewController: Reusable {}

extension UITableView {
    // Safely dequeue a `Reusable` item for a given index path
    func dequeueReusable<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Misconfigured cell type, \(cellClass)!")
        }
        
        return cell
    }
}
