//
//  UIImage+Rotate.swift
//  CURRENCY
//
//  Created by Stan Liu on 16/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import UIKit

extension UIImage {
  func rotate(degrees: CGFloat, flip: Bool) -> UIImage? {
    /*
    let radiansToDegrees: (CGFloat) -> CGFloat = {
      return $0 * (180.0 / CGFloat.pi)
    }*/
    let degreesToRadians: (CGFloat) -> CGFloat = {
      return $0 / 180.0 * CGFloat.pi
    }
    // calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
    let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size

    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap = UIGraphicsGetCurrentContext()

    // Move the origin to the middle of the image so we will rotate and scale around the center.
    bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)

    //   // Rotate the image context
    bitmap?.rotate(by: degreesToRadians(degrees))

    // Now, draw the rotated/scaled image into the context
    let yFlip: CGFloat = {
      return flip ? CGFloat(-1.0) : CGFloat(1.0)
    }()

    bitmap?.scaleBy(x: yFlip, y: -1.0)
    let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)

    bitmap?.draw(cgImage!, in: rect)
    guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
      return nil
    }
    UIGraphicsEndImageContext()

    return newImage
  }
}
