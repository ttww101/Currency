//
//  UIView+Setup.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/24.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

extension UIView {

  func roundCorner(cornerRadius: CGFloat = 4, borderWidth: CGFloat = 0) {
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.masksToBounds = false
  }
}
