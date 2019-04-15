//
//  CardView.swift
//  CURRENCY
//
//  Created by Stan Liu on 28/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

@IBDesignable
class MMCardView: UIView {

  @IBInspectable var cornerRadius: CGFloat = 2

  @IBInspectable var shadowOffsetWidth: Int = 0
  @IBInspectable var shadowOffsetHeight: Int = 3
  @IBInspectable var shadowColor: UIColor? = UIColor.black
  @IBInspectable var shadowOpacity: Float = 0.5

  override func layoutSubviews() {
    layer.cornerRadius = cornerRadius
    let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

    layer.masksToBounds = false
    layer.shadowColor = shadowColor?.cgColor
    layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
    layer.shadowOpacity = shadowOpacity
    layer.shadowPath = shadowPath.cgPath
  }
}
