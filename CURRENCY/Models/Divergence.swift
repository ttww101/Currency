//
//  RateDiff.swift
//  CURRENCY
//
//  Created by Stan Liu on 11/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import Foundation

enum Tendency: String, Codable {
  case rise, fall, even

  init(amount: Decimal) {
    guard amount == 0 else {
      self = amount > 0 ? .rise : .fall
      return
    }
    self = .even
  }
}

struct Divergence: Codable {
  var tendency: Tendency
  var amount: String

  init(amount: String) {
    guard amount.decimalNumber == 0 else {
      self.amount = amount
      self.tendency = Tendency(amount: amount.decimalNumber)
      return
    }
    self.amount = "0.0"
    self.tendency = .even
  }
}
