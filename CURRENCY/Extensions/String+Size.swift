//
//  String+Size.swift
//  CURRENCY
//
//  Created by Stan Liu on 31/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

extension String {
  func sizing(aliment: NSTextAlignment, font: UIFont) -> CGSize {
    let paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
    paragraphStyle?.alignment = aliment
    var drawAttributes = [NSAttributedString.Key: Any]()
    drawAttributes.removeAll()
    drawAttributes[NSAttributedString.Key.font] = font
    drawAttributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle

    let size = self.size(withAttributes: drawAttributes)
    return CGSize(width: ceil(size.width),
                  height: ceil(size.height))
  }
}

extension IndexPath {
  var stringValue: String {
    return String(describing: self)
  }
}
