//
//  Array+Average.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 16/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import Foundation

extension Array where Element: Numeric {
  /// Returns the total sum of all elements in the array
  var total: Element { return reduce(0, +) }
}

extension Array where Element: Numeric {
  /// Returns the average of all elements in the array
  var decimalAverage: Decimal {
    guard let amount = total as? Decimal else {
      return -1
    }
    return isEmpty ? 0 : amount / Decimal(count)
  }
}

extension Array where Element: BinaryFloatingPoint {
  /// Returns the average of all elements in the array
  var average: Element {
    return isEmpty ? 0 : total / Element(count)
  }
}
