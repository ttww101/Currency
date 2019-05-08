//
//  String+dollarMark.swift
//  ExchangeHelper
//
//  Created by curry on 2019/04/28.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
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
