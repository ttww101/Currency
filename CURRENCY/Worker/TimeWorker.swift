//
//  TimeManager.swift
//  CURRENCY
//
//  Created by Stan Liu on 07/02/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

import SwiftyUserDefaults

extension DefaultsKeys {
  static let CurrencySources = DefaultsKey<[String: Any]>("currency_sources")
  static let SourcesLastUpdate = DefaultsKey<String>("source_last_update")
}

// For generic compare which has property date: String
protocol DateStringComparable {
  var date: String { get set }
}

enum TimeSort {
  case oldest
  case latest
}

struct TimeWorker {
  func lastUpdate() -> Date? {
    let datetimeString = Defaults[DefaultsKeys.SourcesLastUpdate]
    return datetimeString.toTime
  }

  func setLastUpdate(lastUpdate: Date) -> Date {
    let datetimeString = lastUpdate.timeStringValue
    Defaults[DefaultsKeys.SourcesLastUpdate] = datetimeString
    return lastUpdate
  }

  // Find the latest date
  static func latestTrade<T: DateStringComparable>(trades: [T]) -> T? {
    return trades.max {
      if let firstDate = $0.date.toPreciseTime, let secondDate = $1.date.toPreciseTime {
        return firstDate < secondDate
      } else if let firstDate = $0.date.toTime, let secondDate = $1.date.toTime {
        return firstDate < secondDate
      } else if let firstDate = $0.date.toDate, let secondDate = $1.date.toDate {
        return firstDate < secondDate
      } else if let firstDate = $0.date.toMonthDay, let secondDate = $1.date.toMonthDay {
        return firstDate < secondDate
      } else {
        // If nil return true, because the last object MAYBE the latest one.
        return true
      }
    }
  }

  // Find today
  static func todayTrade<T: DateStringComparable>(trades: [T]) -> T? {
    return trades.filter {
      return $0.date.keepMonthDay == Date().onlyDateStringValue
      }.first
  }
}
