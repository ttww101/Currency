//
//  Double+DecimalPoint.swift
//  CURRENCY
//
//  Created by Stan Liu on 03/01/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation
import Darwin

extension Decimal {

  mutating func decimal(after position: Int) -> Decimal {
    let decimalString = self.decimalString(after: position)
    return decimalString.decimalNumber
  }

  var userSettingDecimal: Decimal {
    var decimalNumber = self
    return decimalNumber.decimal(after: UserSettings.decimalPoint())
  }

  var calculationDecimalString: String {
    let decimalNumber = self
    guard decimalNumber != 0 else {
      // if decimal number is equal zero, return zero string but not decimal
      return "0.0"
    }
    return decimalNumber.userSettingDecimal.stringValue
  }

  mutating func decimalString(after position: Int) -> String {
    let divisor: Decimal = pow(10, position)
    let fraction = round((self * divisor).doubleValue)
    let result = fraction / divisor.doubleValue
    // To remove the useless zero after decimal point
    let resultNumber = NSDecimalNumber(decimal: result.decimalNumber)
    return Configuration.Number().formatter(position: position).string(from: resultNumber) ?? "n/a"
    //return String(format: "%.\(position)f", result) 
  }

  var doubleValue: Double {
    let double = Double(truncating: self as NSDecimalNumber)
    return double
  }

  var stringValue: String {
    let doubleValue = self.doubleValue
    return String(doubleValue)
  }
}

extension String {

  var decimalNumber: Decimal {
    return Decimal(NSString(string: self).doubleValue)
  }

  mutating func decimal(after position: Int) -> String {
    var decimal = self.decimalNumber
    return decimal.decimalString(after: position)
  }

  var userSettingDecimal: String {
    var decimal = self
    let numberSet = CharacterSet(charactersIn: ".0123456789")
    guard decimal.rangeOfCharacter(from: numberSet) != nil else {
      // If decimal is empty string ""
      return "/"
    }
    let afterD = decimal.decimal(after: UserSettings.decimalPoint())
    return afterD
  }
}

extension Double {
  var decimalNumber: Decimal {
    return Decimal(self)
  }
}

extension Int {
  var stringValue: String {
    return String(describing: self)
  }
}

extension String {
  var intValue: Int {
    return NSString(string: self).integerValue
  }
  var doubleValue: Double {
    return NSString(string: self).doubleValue
  }
}
