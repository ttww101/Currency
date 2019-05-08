//
//  UIView+Setup.swift
//  ExchangeHelper
//
//  Created by curry on 2019/04/28.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

extension UIView {

  func roundCorner(cornerRadius: CGFloat = 4, borderWidth: CGFloat = 0) {
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.masksToBounds = false
  }
}
