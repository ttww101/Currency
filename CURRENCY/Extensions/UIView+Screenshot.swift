//
//  UIView+Screenshot.swift
//  ExchangeHelper
//
//  Created by curry on 2019/04/28.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

extension UIView {
  var screenshot: UIImage? {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, 1.0)
    guard UIGraphicsGetCurrentContext() != nil else { return nil }
    drawHierarchy(in: bounds, afterScreenUpdates: true)
    let screenshot = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return screenshot
  }
}
