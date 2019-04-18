//
//  HistoryCurrencyModels.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 28/03/2018.
//  Copyright (c) 2018 Meiliang Wen. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum HistoryCurrency {
  // MARK: Use cases
  enum Load {
    struct Request {
    }
    struct Response {
      var name: String
    }
    struct ViewModel {
      var name: String
    }
  }

  enum Fetch {
    struct Request {
      var period: Period
    }
    struct Response {
      var period: Period
      var histories: [HistoryModelize]
    }
    struct ViewModel {
      var dates: [String]
      var rates: [Decimal]
    }
  }

  enum Storage {
    struct HistoryStorage {
      var histories3Y: [HistoryModelize]?
      var histories1Y: [HistoryModelize]?
      var histories6M: [HistoryModelize]?
      var histories3M: [HistoryModelize]?
      //var histories1M: [HistoryModelize]? { get set }
      var histories1D: [HistoryModelize]?

      init() { }

      func getHistory(period: Period) -> [HistoryModelize]? {
        switch period {
        case .today:
          return histories1D
          //case .month:
        //  tempRates = rates1M
        case .month3:
          return histories3M
        case .month6:
          return histories6M
        case .year:
          return histories1Y
        case .year3:
          return histories3Y
        }
      }

      mutating func setHistory(period: Period, history: [HistoryModelize]) {
        switch period {
        case .today:
          histories1D = history
          //case .month:
        //  tempRates = rates1M
        case .month3:
          histories3M = history
        case .month6:
          histories6M = history
        case .year:
          histories1Y = history
        case .year3:
          histories3Y = history
        }
      }
    }
  }
}
