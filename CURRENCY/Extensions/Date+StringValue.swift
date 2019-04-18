//
//  Date+StringValue.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 18/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import Foundation

extension Date {

  var onlyDateStringValue: String {
    return Configuration.Date().mdFormatter.string(from: self)
  }

  var dateStringValue: String {
    return Configuration.Date().dateFormatter.string(from: self)
  }

  var timeStringValue: String {
    return Configuration.Date().timeFormatter.string(from: self)
  }

  var preciseTimeStringValue: String {
    return Configuration.Date().preciseTimeFormatter.string(from: self)
  }

  var isToday: Bool {
    return NSCalendar.current.isDateInToday(self)
  }
}

extension String {

  var toMonthDay: Date? {
    return Configuration.Date().mdFormatter.date(from: self)
  }

  var toDate: Date? {
    return Configuration.Date().dateFormatter.date(from: self)
  }

  var toTime: Date? {
    return Configuration.Date().timeFormatter.date(from: self)
  }

  var toPreciseTime: Date? {
    return Configuration.Date().preciseTimeFormatter.date(from: self)
  }

  func dateSeperatorReplace(by newSeperator: String) -> String {
    var seperator: String!
    if self.contains("-") {
      seperator = "-"
    } else if self.contains("/") {
      seperator = "/"
    } else if self.contains(".") {
      seperator = "."
    } else {
      fatalError("DateString format seperator is wrong")
    }
    return self.replacingOccurrences(of: seperator, with: newSeperator)
  }

  /// e.g. 2016/12/22 13:50
  var onlyTimeString: String {
    let strings = self.split(separator: " ")
    let timeStrings = String(describing: strings.last ?? "").split(separator: ":").dropLast()
    return timeStrings.joined(separator: ":")
  }

  /// Only Month/Day, e.g. 01/20
  var keepMonthDay: String {
    let newString = dateSeperatorReplace(by: "/")
    if self.contains("T") {
      let removedTimeZoneStrings = newString.split(separator: "T")
      guard removedTimeZoneStrings.count > 1 else {
        return self
      }
      let dateString = removedTimeZoneStrings.dropLast().reduce("") { return String($0 + $1) }
      return dateString.removeYear("/")
    }
    return newString.removeYear("/")
  }

  /// Only keep month
  var onlyMonth: String {
    let dateComponents = self.keepMonthDay.split(separator: "/")
    print("month: \(dateComponents.first ?? "")")
    return String(describing: dateComponents.first ?? "")
  }

  /// convert 2018-08-03 to 08/03
  func removeYear(_ seperator: Character) -> String {
    let subStrings = self.split(separator: seperator)
    guard let firstSubString = subStrings.first, firstSubString.count >= 3 else {
      return self
    }
    let newSubStrigs = subStrings.dropFirst().map { String($0) }
    return newSubStrigs.compare { (prev, next) -> String in
      return prev + "/" + next
      }.reduce("") {
        return $0 + $1
    }
  }
}

extension Array where Element: StringProtocol {

  var toDates: [Date]? {
    guard let dateStrings = self as? [String] else { return [] }
    var dates: [Date] = []
    for dateString in dateStrings {
      guard let date = Configuration.Date().dateFormatter.date(from: dateString) else {
        return nil
      }
      dates.append(date)
    }
    return dates
  }
}
