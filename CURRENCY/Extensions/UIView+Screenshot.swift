//
//  UIView+Screenshot.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 28/03/2018.
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
