//
//  View+Helper.swift
//  GithubSuperStars
//
//  Created by Hardik on 23/04/17.
//  Copyright © 2017 Ugam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// add rounded corner boarder around Add button
    func addBoarderAndRoundCorner(forCorner corners: UIRectCorner, radius: Double = 5.0) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds,
                                       byRoundingCorners: corners,
                                       cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    func circular(borderWidth: CGFloat = 1, borderColor: UIColor = .gray) {
        let radius = self.bounds.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
}
