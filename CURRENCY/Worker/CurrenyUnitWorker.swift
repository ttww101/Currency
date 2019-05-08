//
//  CurrenyUnitWorker.swift
//  ExchangeHelper
//
//  Created by wang on 2019/04/24.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

struct CurrencyUnitWorker {

  func setBank(with banks: [TWBank.Bank]) -> [TWBank.Bank] {
    // Find unit in currencies
    let unitName = KKUserSetting.currencyUnit
    if unitName == "twd" { return banks }
    var mutableBanks = banks
    guard let unit = banks.filter({ $0.currency.name == unitName }).first else {
      // doesn't have, use usd to be currency unit
      guard let usd = banks.filter({ $0.currency.name == "usd" }).first else {
        return banks
      }
      return mutableBanks.map {
        return TWBank.Bank(name: $0.name,
                           swiftCode: $0.swiftCode,
                           fee: $0.fee,
                           imageURL: $0.imageURL,
                           currency: TWBank.Currency(name: $0.currency.name,
                                                     buy: ($0.currency.buy.decimalNumber / usd.currency.buy.decimalNumber).stringValue,
                                                     sell: ($0.currency.sell.decimalNumber / usd.currency.sell.decimalNumber).stringValue,
                                                     lastUpdate: $0.currency.lastUpdate,
                                                     imageURL: $0.currency.imageURL))
      }
    }
    return mutableBanks.map {
      return TWBank.Bank(name: $0.name,
                         swiftCode: $0.swiftCode,
                         fee: $0.fee,
                         imageURL: $0.imageURL,
                         currency: TWBank.Currency(name: $0.currency.name,
                                                   buy: ($0.currency.buy.decimalNumber / unit.currency.buy.decimalNumber).stringValue,
                                                   sell: ($0.currency.sell.decimalNumber / unit.currency.sell.decimalNumber).stringValue,
                                                   lastUpdate: $0.currency.lastUpdate,
                                                   imageURL: $0.currency.imageURL))
    }
  }

  func setCurrencyUnit(with currencies: [(CurrencyBasic & CarryLastUpdate & CarryImageURL)]) -> [(CurrencyBasic & CarryLastUpdate & CarryImageURL)] {
    // Find unit in currencies
    let unitName = KKUserSetting.currencyUnit
    var mutableCurrencies = currencies
    // 1. unit is twd, use straight
    if unitName == "twd" { return currencies }
    mutableCurrencies.insert(TWBank.Currency(name: "twd",
                                             buy: "1.0",
                                             sell: "1.0",
                                             lastUpdate: mutableCurrencies.first?.lastUpdate
                                              ?? mutableCurrencies.last?.lastUpdate
                                              ?? "",
                                             imageURL: nil), at: 0)

    // 2. check is bank currencies has currency (unit)
    guard let unit = mutableCurrencies.filter({ $0.name == unitName }).first else {
      // doesn't have, use usd to be currency unit
      guard let usd = mutableCurrencies.filter({ $0.name == "usd" }).first else {
        return currencies
      }
      return mutableCurrencies.map {
        return TWBank.Currency(name: $0.name, // unit / subject * content
          buy: ($0.buy.decimalNumber / usd.buy.decimalNumber).stringValue,
          sell: ($0.sell.decimalNumber / usd.sell.decimalNumber).stringValue,
          lastUpdate: $0.lastUpdate,
          imageURL: $0.imageURL)
      }
    }
    // do have
    return mutableCurrencies.map {
      return TWBank.Currency(name: $0.name, // unit / subject * content
        buy: ($0.buy.decimalNumber / unit.buy.decimalNumber).stringValue,
        sell: ($0.sell.decimalNumber / unit.sell.decimalNumber).stringValue,
        lastUpdate: $0.lastUpdate,
        imageURL: $0.imageURL)
    }
  }

}
