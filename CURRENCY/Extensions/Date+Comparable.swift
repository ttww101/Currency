//
//  File.swift
//  CURRENCY
//
//  Created by Stan Liu on 24/01/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

extension Date {

  var isBefore30MinsBefore: Bool {
    return Date.millionSeconds(self.millionSeconds + 1800) < Date()
  }
}
