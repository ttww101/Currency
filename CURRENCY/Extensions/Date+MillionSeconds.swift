//
//  Date+MillionSeconds.swift
//  CURRENCY
//
//  Created by Stan Liu on 23/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import Foundation

extension Date {

  static func millionSeconds(_ second: Double) -> Date {
    let timeInteval = Double(second)
    let date = Date.init(timeIntervalSince1970: timeInteval)
    return date
  }

  var millionSeconds: Double {
    return Double(self.timeIntervalSince1970)
  }
}
