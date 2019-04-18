//
//  Source.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 27/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

enum Period: String {
  case today = "1d"
  //case month = "30d"
  case month3 = "3M"
  case month6 = "6M"
  case year = "1Y"
  case year3 = "3Y"

  static let `defaultValue` = Period.month3
  static let all: [Period] = [.today, .month3, .month6, .year, .year3]

  init?(name: String) {
    for period in Period.all where period.shortTitle == name {
      self = period
      return
    }
    return nil
  }

  var shortTitle: String {
    switch self {
    case .today:
      return "1D"
    //case .month:
    //  return "1M"
    case .month3:
      return "3M"
    case .month6:
      return "6M"
    case .year:
      return "1Y"
    case .year3:
      return "3Y"
    }
  }

  var count: Int {
    switch self {
    case .today:
      return 1
    //case .month:
    //  return 30
    case .month3:
      return 30
    case .month6:
      return 180
    case .year:
      return 365
    case .year3:
      return 1095
    }
  }

  var index: Int {
    for (index, period) in Period.all.enumerated()
      where period == self {
        return index
    }
    return 0
  }

  var interval: Interval {
    switch self {
    case .today:
      return Interval.minute5
    default:
      return Interval.day
    }
  }
}

enum Interval: Int {
  case minute = 60
  case minute5 = 300
  case hour = 3600
  case day = 86400
}

// MARK: Trade
enum TradeType {
  case buy, sell

  func trade(trade: [Trade]) -> [String] {
    switch self {
    case .buy:
      return trade.map { $0.buy.amount }
    case .sell:
      return trade.map { $0.sell.amount }
    }
  }
}

// MARK: Exchange
enum ExchangeType {
  case cash, stock

  func exchanges(investmentSubject: InvestmentSubject) -> [Trade] {
    switch self {
    case .cash:
      return investmentSubject.cash
    case .stock:
      return investmentSubject.stock
    }
  }

  var rawValue: String {
    switch self {
    case .cash:
      return "cash"
    case .stock:
      return "check"
    }
  }
}

enum Source {
  // base, subject, period
  case google(String, String, Period)
  // subject, period
  case bot(String?, Period?)
  case rter(Rter, ExchangeType?)

  enum Currency {
    static let all = APP.Preference.currency.options
  }

  static let all = [Source.bot(nil, nil)]

  var currencies: [String] {
    switch self {
    case .google:
      return APP.Preference.currency.options
    case .bot:
      return APP.Preference.currency.options
    case .rter:
      return APP.Preference.currency.options
    }
  }
}

extension Source {
  var name: String {
    switch self {
    case .google:
      return "google"
    case .bot:
      return "BKTWTWTP"
    case .rter(let rter):
      return rter.0.name
    }
  }

  var base: String {
    switch self {
    case .google(let base, _, _):
      return base
    case .bot:
      return ""
    case .rter:
      return ""
    }
  }

  var subject: String? {
    switch self {
    case .google(_, let subject, _):
      return subject
    case .bot(let subject, _):
      return subject
    case .rter:
      return ""
    }
  }

  var exchangeType: ExchangeType? {
    switch self {
    case .google:
      return nil
    case .bot:
      return nil
    case .rter(let rter):
      return rter.1
    }
  }

  var period: Period? {
    switch self {
    case .google(_, _, let period):
      return period
    case .bot(_, let period):
      return period
    case .rter:
      return nil
    }
  }

  var url: String {
    switch self {
      // https://finance.google.com/finance/getprices?p=1d&amp;f=d,o,h,l,c,v&amp;q=MSFT&amp;i=60&amp;x=NASD
      // p is period, is the horizon over which to fetch data: 1 day
      // f defines what should be fetched: date, open, high, low, close, volume
      // q is the stock to fetch: Apple
      // i defines the interval in seconds: every 60 seconds
      // x is the exchange from which to fetch: NASDAQ
    case .google(let base, let subject, let period):
      let q = subject.uppercased() + base.uppercased()
      let p = "\(period.rawValue)"
      if period == .today {
        let i = "\(Interval.minute5.rawValue)"
        return "https://finance.google.com/finance/getprices?q=\(q)&p=\(p)&i=\(i)&f=d,c"
      } else {
        let i = "\(Interval.day.rawValue)"
        return "https://finance.google.com/finance/getprices?q=\(q)&p=\(p)&i=\(i)&f=d,c"
      }
    case .bot(let subject, let interval):
      guard let subject = subject,
        let interval = interval else {
        // return "http://rate.bot.com.tw/xrt/flcsv/0/day" // CSV
        return "http://rate.bot.com.tw/xrt/fltxt/0/day" // plain string
      }
      switch interval {
      case .today:
        return "http://rate.bot.com.tw/xrt/quote/day/\(subject)"
      case .month3:
        return "http://rate.bot.com.tw/xrt/quote/ltm/\(subject)"
      case .month6:
        return "http://rate.bot.com.tw/xrt/quote/l6m/\(subject)"
      case .year, .year3:
        return ""
      }
    case .rter(let rter, let e):
      guard let e = e else {
        fatalError("Retrive Source.rter url should give exchangeType")
      }
      return rter.url(exchange: e)
    }
  }

  func apiError(of subject: String, interval: Period) -> (() -> Void)? {
    switch self {
    case .bot:
      switch interval {
      case .year:
        return {
          fatalError("NO data of current source")
        }
      default:
        return nil
      }
    default:
      return nil
    }
  }
}
