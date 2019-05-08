//
//  APIAnalyzer.swift
//  ExchangeHelper
//
//  Created by wang on 2019/04/21.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Kanna
import CSV

protocol HistoryModelize {
  var date: Date { get set }
  var open: String? { get set }
  var close: String { get set }
  var high: String? { get set }
  var low: String? { get set }
  var volume: String? { get set }
}

struct GoogleHistory: HistoryModelize {
  var date: Date
  var open: String?
  var close: String
  var high: String?
  var low: String?
  var volume: String?
  init(date: Date,
       open: String? = nil,
       close: String,
       high: String? = nil,
       low: String? = nil,
       volume: String? = nil) {
    self.date = date
    self.open = open
    self.close = close
    self.high = high
    self.low = low
    self.volume = volume
  }
}

struct YahooHistory: HistoryModelize {
  var date: Date
  var open: String?
  var close: String
  var high: String?
  var low: String?
  var volume: String?
}

func contains(for regex: String, in text: String) -> Bool {
  do {
    let regex = try NSRegularExpression(pattern: regex)
    let nsString = text as NSString
    let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
    return results.count > 0
  } catch let error {
    print("invalid regex: \(error.localizedDescription)")
    return false
  }
}

struct APIAnalyzer {

  //  let type = results[0]
  //  let marketOpenMinute = results[1]
  //  let marketCloasMinute = results[2]
  //  let interval = results[3]
  //  let columns = results[4]
  //  let data = results[5]
  //  let timezone = results[6]
  func google(stringValue: String, interval: Interval) -> [GoogleHistory] {
    var results = stringValue.split(separator: "\n")
    guard results.count > 7 else {
      return []
    }
    results.removeFirst(7)
    var initialUnix: Double = 0
    let analyzedResults = results.map { (valueString) -> GoogleHistory in
      let splits = valueString.split(separator: ",")
      // For Daily
      if splits.count == 5 {
        let date = "\(splits[0])" // a123213120414 or index
        let close = "\(splits[1])"
        let open = "\(splits[2])"
        let high = "\(splits[3])"
        let low = "\(splits[4])"

        // if date is unix or index
        if contains(for: "[a-z]", in: date) && date.count > 6 {
          initialUnix = date.trimmingCharacters(in: CharacterSet(charactersIn: "a-z")).doubleValue
          return GoogleHistory(date: Date(timeIntervalSince1970: initialUnix),
                               close: close)
        } else {
          let unix = initialUnix + Double(date.intValue * interval.rawValue)
          return GoogleHistory(date: Date(timeIntervalSince1970: unix),
                               open: open,
                               close: close,
                               high: high,
                               low: low)
        }
      // For Monthly, Yearly
      } else if splits.count == 2 {
        let date = "\(splits[0])"
        let close = "\(splits[1])"

        if contains(for: "[a-z]", in: date) && date.count > 6 {
          initialUnix = date.trimmingCharacters(in: CharacterSet(charactersIn: "a-z")).doubleValue
          return GoogleHistory(date: Date(timeIntervalSince1970: initialUnix),
                               close: close)
        } else {
          let unix = initialUnix + Double(date.intValue * interval.rawValue)
          return GoogleHistory(date: Date(timeIntervalSince1970: unix),
                               close: close)
        }
      } else {
        return GoogleHistory(date: Date(timeIntervalSince1970: 0),
                             close: "")
      }
    }
    return analyzedResults
  }

  func rterBank(rter: Rter, json: JSON) -> RterBank<[RterCurrency]>? {
    var currencies: [RterCurrency] = []
    let data = json["data"].arrayValue
    for bank in data {
      let infos = bank.arrayValue
      if infos.count > 4 {
        guard
          let htmlString = infos[0].string,
          let doc = try? HTML(html: htmlString, encoding: .utf8),
          let name = doc.text,
          //let swiftCode = htmlString.slice(from: "href=\"", to: "\""),
          let imageURL = htmlString.slice(from: "img src=\"", to: "\""),
          let buy = infos[1].string,
          let sell = infos[2].string,
          let lastUpdate = infos[3].string// ,
          //let fee = infos[4].string
          else { return nil }
        let currencyKey = LanguageDictionary().getCurrencyLocalizedKey(from: name) ?? name
        let currency = RterCurrency(name: currencyKey, // Assign Currency name with localized key
                                    buy: buy,
                                    sell: sell,
                                    lastUpdate: lastUpdate,
                                    imageURL: "https://tw.rter.info" + imageURL)
        currencies.append(currency)
      }
    }
    let bank = RterBank<[RterCurrency]>(name: rter.name, // Already localized key (swift code)
                                        swiftCode: rter.name,
                                        fee: "",
                                        imageURL: nil,
                                        currency: currencies)
    return bank
  }
  func rterCurrency(rter: Rter, json: JSON) -> [RterBank<RterCurrency>]? {
    let subject = rter.name // currency
    var banks: [RterBank<RterCurrency>] = []
    let data = json["data"].arrayValue
    for bank in data {
      let infos = bank.arrayValue
      if
        infos.count > 4,
        let htmlString = infos[0].string,
        let doc = try? HTML(html: htmlString, encoding: .utf8),
        let name = doc.text,
        let swiftCode = htmlString.slice(from: "href=\"", to: "\""),
        let imageURL = htmlString.slice(from: "img src=\"", to: "\""),
        let buy = infos[1].string,
        let sell = infos[2].string,
        let lastUpdate = infos[3].string,
        let fee = infos[4].string {
        let currency = RterCurrency(name: subject, // Already currency localized key
                                    buy: buy,
                                    sell: sell,
                                    lastUpdate: lastUpdate,
                                    imageURL: nil)
        let bankKey = LanguageDictionary().getBankLocalizedKey(from: name) ?? name
        let bank = RterBank<RterCurrency>(name: bankKey, // Assign bank name with localized key
                                          swiftCode: swiftCode,
                                          fee: fee,
                                          imageURL: imageURL,
                                          currency: currency)
        banks.append(bank)
      } else {
        return nil
      }
    }
    return banks
  }

  func bankOfTaiwan(subject: String, period: Period, json: JSON) -> InvestmentSubject? {

    guard
      let doc = try? HTML(html: json.stringValue, encoding: .utf8),
      let table = doc.at_css("table"),
      let tbody = table.at_css("tbody")
      else
    {
      return nil
    }
    let list = tbody.css("tr")
    var subjectName: String = ""
    var cash: [Trade] = []
    var stock: [Trade] = []
    list.forEach {
      if let row = try? HTML(html: $0.text!, encoding: .utf8).text,
        let values = row?.components(separatedBy: "\r\n"),
        let createdAt = values.first {
        subjectName = values[1]
        let cash_buy = Rate(date: createdAt, amount: values[2].removeAllSymbol)
        let cash_sell = Rate(date: createdAt, amount: values[3].removeAllSymbol)
        let stock_buy = Rate(date: createdAt, amount: values[4].removeAllSymbol)
        let stock_sell = Rate(date: createdAt, amount: values[5].removeAllSymbol)
        cash.append(Trade(buy: cash_buy, sell: cash_sell))
        stock.append(Trade(buy: stock_buy, sell: stock_sell))
      }
    }
    guard
      cash.count > 0 &&
        stock.count > 0
      else {
        return nil
    }
    let investmentSubject = InvestmentSubject(name: subjectName.removeSpace.takeEng.lowercased(),
                                              lastUpdate: Date(),
                                              cash: cash,
                                              stock: stock)
    DataManager().save(source: Source.rter(.bank(.bankoftaiwan), nil), currency: investmentSubject)
    return investmentSubject
  }

  func bankOfTaiwanAllToday(json: JSON) -> CurrencySource? {
    guard let csv = try? CSVReader(string: json.stringValue,
                                   hasHeaderRow: true) else {
                                    return nil
    }
    var currencies: [InvestmentSubject] = []
    let date = Date()
    while let row = csv.next() {
      if let values = row.first?.split(separator: " "),
        let subject = values.first {
        let cashBuy = Rate(date: date.dateStringValue, amount: String(describing: values[2]))
        let cashSell = Rate(date: date.dateStringValue, amount: String(describing: values[12]))
        let stockBuy = Rate(date: date.dateStringValue, amount: String(describing: values[3]))
        let stockSell = Rate(date: date.dateStringValue, amount: String(describing: values[13]))
        let investmentSubject = InvestmentSubject(name: subject.lowercased(),
                                                  lastUpdate: date,
                                                  cash: [Trade(buy: cashBuy,
                                                               sell: cashSell)],
                                                  stock: [Trade(buy: stockBuy,
                                                                sell: stockSell)])
        currencies.append(investmentSubject)
      }
    }
    guard currencies.count > 0 else {
      return nil
    }
    let twdRate = Rate(date: date.dateStringValue, amount: "1.0")
    currencies.insert(InvestmentSubject(name: "twd",
                                        lastUpdate: date,
                                        cash: [Trade(buy: twdRate, sell: twdRate)],
                                        stock: [Trade(buy: twdRate, sell: twdRate)]),
                      at: 0)
    let source = CurrencySource(name: Rter.bank(.bankoftaiwan).name,
                                currencies: currencies)
    DataManager().saveAll(source: Source.rter(.bank(.bankoftaiwan), nil), currencySource: source)
    return source
  }
}
