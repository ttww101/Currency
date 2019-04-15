//
//  CurrencyModels.swift
//  CURRENCY
//
//  Created by Stan Liu on 09/11/2017.
//  Copyright (c) 2017 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Currency {

  struct FetchError {
    struct Request { }
    struct Response {
      var description: String
    }
    struct ViewModel {
      var description: String
    }
  }

  // MARK: Scene subject
  enum Subject {
    struct Request {
      var tradeType: TradeType
      var exchangeType: ExchangeType?

      init(tradeType: TradeType = .buy,
           exchangeType: ExchangeType? = nil) {
        self.tradeType = tradeType
        self.exchangeType = exchangeType
      }

    }

    struct Response {
      var subject: InvestmentSubject
      var tradeType: TradeType
      var exchangeType: ExchangeType?
    }

    // MARK: Convert to display model
    struct ViewModel {

      struct DisplayRate: DateStringComparable {
        var date: String
        var amount: String
        var tendency: Tendency
        var divergenceAmount: String
      }

      struct DisplayTrade: DateStringComparable {
        var date: String
        var buy: DisplayRate
        var sell: DisplayRate
      }

      struct DisplaySubject {
        var name: String
        var lastUpdate: String
        var cash: [DisplayTrade]
        var stock: [DisplayTrade]
      }

      struct DisplaySource {
        var name: String
        var currencies: [DisplaySubject]
      }

      var displaySubject: DisplaySubject

      init(displaySubject: DisplaySubject) {
        self.displaySubject = displaySubject
      }

    }
  }
}
