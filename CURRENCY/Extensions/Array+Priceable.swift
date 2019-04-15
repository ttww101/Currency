//
//  Array+Priceable.swift
//  CURRENCY
//
//  Created by Stan Liu on 19/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import Foundation

extension Array where Element: RateModel {

  var amountAverage: Decimal {
    let decimals = self.map {
      return $0.amount.decimalNumber
    }
    return decimals.decimalAverage
  }
}

extension Array where Element: TradeModel {

  func average(of tradeType: TradeType) -> Decimal {
    let decimals = self.map {
      return tradeType == .buy
        ? $0.buy.amount.decimalNumber
        : $0.sell.amount.decimalNumber
    }
    return decimals.decimalAverage
  }
}
