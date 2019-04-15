//
//  String+dollarMark.swift
//  CURRENCY
//
//  Created by Stan Liu on 16/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import Foundation

extension String {

  var dollarMark: String {
    return self.contains("$ ") ? self : "$ \(self)"
  }

  var antiDollarMark: String {
    return NSString(string: self).replacingOccurrences(of: "$", with: "").replacingOccurrences(of: " ", with: "")
  }

  var cleanValue: String {
    return NSString(string: self)
      .replacingOccurrences(of: "$", with: "")
      .replacingOccurrences(of: " ", with: "")
      .replacingOccurrences(of: ",", with: "")
  }
}
