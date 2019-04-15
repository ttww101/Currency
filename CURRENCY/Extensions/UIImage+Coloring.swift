//
//  UIImage+Coloring.swift
//  CURRENCY
//
//  Created by Stan Liu on 16/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import UIKit

extension UIImage {
  func coloring(on color: UIColor) -> UIImage? {

    UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()
    color.setFill()
    context!.translateBy(x: 0, y: self.size.height)
    context!.scaleBy(x: 1.0, y: -1.0)
    context!.setBlendMode(CGBlendMode.colorBurn)
    let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    context!.draw(self.cgImage!, in: rect)
    context!.setBlendMode(CGBlendMode.sourceIn)
    context!.addRect(rect)
    context!.drawPath(using: CGPathDrawingMode.fill)

    let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return coloredImage
  }

  func colorRenderer(on color: UIColor) -> UIImage? {
    return self.withRenderingMode(.alwaysTemplate)
  }
}
