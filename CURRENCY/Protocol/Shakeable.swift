//
//  Shakeable.swift
//  ExchangeHelper
//
//  Created by bryan on 2019/05/03.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

protocol Shakeable {
  func shake()
}

extension Shakeable where Self: UIView {
  func shake() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.05
    animation.repeatCount = 5
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
    layer.add(animation, forKey: "position")
  }
}

extension UITableViewCell: Shakeable { }
extension UITextField: Shakeable { }
