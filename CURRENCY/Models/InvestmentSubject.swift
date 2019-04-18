//
//  InvestmentSubject.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 10/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol RateModel {
  var date: String { get set }
  var amount: String { get set }
  var divergence: Divergence? { get set }
}

protocol TradeModel {
  var date: String { get }
  var buy: Rate { get set }
  var sell: Rate { get set }
}

protocol SubjectModel {
  var name: String { get set }
  var lastUpdate: Date { get set }
  var cashTrade: [Trade] { get set }
  var stockTrade: [Trade] { get set }
}

protocol SourceModel {
  var investmentSubjects: [InvestmentSubject] { get set }
}

struct Rate: RateModel, Codable {
  var date: String
  var amount: String
  var divergence: Divergence?

  init(date: String,
       amount: String,
       divergence: Divergence? = nil) {
    self.date = date
    if amount.decimalNumber == 0 {
      self.amount = ""
    } else {
      self.amount = amount
    }
    self.divergence = divergence
  }

  init(rateDict: [String: Any]) {
    if let rateDict = rateDict as? [String: JSON] {
      self.date = rateDict["created_at"]?.stringValue ?? ""
      self.amount = rateDict["amount"]?.stringValue ?? ""
      return
    }
    if let rateDict = rateDict as? [String: String] {
      self.date = rateDict["created_at"] ?? ""
      self.amount = rateDict["amount"] ?? ""
      return
    }
    self.date = ""
    self.amount = ""
  }

  mutating func calculateDivergence(from lastRate: Rate) {
    self.divergence = Divergence(amount: { () -> String in
      let lastAmount = lastRate.amount
      let differenceOfAmount = self.amount.decimalNumber - lastAmount.decimalNumber
      return differenceOfAmount.calculationDecimalString
    }()
    )
  }

  var mapping: Currency.Subject.ViewModel.DisplayRate {
    let tendency = divergence?.tendency ?? .even
    let divergenceAmount = divergence?.amount ?? "0.0"
    return Currency.Subject.ViewModel.DisplayRate(date: date,
                                                  amount: amount,
                                                  tendency: tendency,
                                                  divergenceAmount: divergenceAmount)
  }
}

struct Trade: TradeModel, Codable {
  var date: String {
    guard buy.date == sell.date else {
      fatalError("buy.date should equal to sell.date")
    }
    return buy.date
  }
  var buy: Rate
  var sell: Rate

  var mapping: Currency.Subject.ViewModel.DisplayTrade {
    return Currency.Subject.ViewModel.DisplayTrade(date: date,
                                                   buy: buy.mapping,
                                                   sell: sell.mapping)
  }
}

struct InvestmentSubject: Codable {
  var name: String
  var lastUpdate: Date
  var cash: [Trade]
  var stock: [Trade]

  mutating func calculate() {
    let worker = CurrencyWorker()
    let newSubject = worker.calculateDivergence(of: self)
    self.cash = newSubject.cash
    self.stock = newSubject.stock
  }

  mutating func mapping() -> Currency.Subject.ViewModel.DisplaySubject {
    self.calculate()
    return Currency.Subject.ViewModel.DisplaySubject(name: name,
                                                     lastUpdate: lastUpdate.timeStringValue,
                                                     cash: cash.map { $0.mapping },
                                                     stock: stock.map { $0.mapping })
  }
}

struct CurrencySource: Codable {
  var name: String
  var currencies: [InvestmentSubject]

  mutating func mapping() -> Currency.Subject.ViewModel.DisplaySource {
    let displaySubjects = self.currencies.map { (subject) -> Currency.Subject.ViewModel.DisplaySubject in
      var s = subject
      return s.mapping()
    }
    return Currency.Subject.ViewModel.DisplaySource(name: self.name,
                                                    currencies: displaySubjects)
  }
}
