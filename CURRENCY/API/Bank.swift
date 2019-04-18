//
//  Bank.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 27/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

enum Rter {
  case bank(Bank)
  case currency(String)

  init?(swiftCode: String) {
    for bank in Bank.all where bank.swiftCode == swiftCode {
        self = .bank(bank)
        return
    }
    return nil
  }
}

extension Rter {
  var rawValue: String {
    switch self {
    case .bank:
      return "bank"
    case .currency:
      return "currency"
    }
  }
  var name: String {
    switch self {
    case .bank(let bank):
      return bank.swiftCode
    case .currency(let currency):
      return currency.lowercased()
    }
  }
  func url(exchange: ExchangeType) -> String {
    
    switch self {
        
    case .bank(let bank):
      return bank.url(exchange: exchange)
    case .currency(let subject):
      //https://tw.rter.info/json.php?t=currency&q=cash&iso=USD
      let q = exchange.rawValue
      let iso = subject.uppercased()
      return "https://tw.rter.info/json.php?t=currency&q=\(q)&iso=\(iso)"
    }
  }
}

enum Bank {
  case bankoftaiwan // 台灣銀行ㄌㄨ
  case landbank // 土地銀行
  case firstbank // 第一銀行
  case huananbank // 華南銀行
  case changhwabank // 彰化銀行
  case shanghaicommercialsavingbank // 上海商銀
  case fuban // 台北富邦
  case cathayunited // 國泰世華
  case bankofkaosiung // 高雄銀行
  case mega // 兆豐商銀
  case citi // 花旗台灣
  case anz // 澳盛銀行
  case taiwanbusinessbank // 台灣中小企業銀行
  case standardchartered // 渣打銀行
  case taiwancooperativebank // 合作金庫
  case taichungbank // 台中銀行
  case ktb // 京城商銀
  case hsbc // 匯豐台灣
  case skbank // 新光銀行
  case sunnybank // 陽信銀行
  case bankofpanhsin // 板信銀行
  case cotabank // 三信商銀
  case unionbankoftaiwan // 聯邦銀行
  case fareasternbank // 遠東商銀
  case yuantabank // 元大銀行
  case taishin // 台新銀行
  case kgi // 凱基銀行
  case chinatrust // 中國信託
  case dbs // 星展銀行
  case entie // 安泰商銀
  case jihsun // 日盛銀行
  case esun // 玉山銀行
  case sinopac // 永豐銀行
  case taipeistar // 瑞興銀行

  static let all: [Bank] = [
    .bankoftaiwan, .landbank, .firstbank,
    .huananbank, .changhwabank, .shanghaicommercialsavingbank,
    .fuban, .cathayunited, .bankofkaosiung,
    .mega, .citi, .anz,
    .taiwanbusinessbank, .standardchartered, .taiwancooperativebank,
    .taichungbank, .ktb, .hsbc,
    .skbank, .sunnybank, .bankofpanhsin,
    .cotabank, .unionbankoftaiwan, .fareasternbank,
    .yuantabank, .taishin, .kgi,
    .chinatrust, .dbs, .entie,
    .jihsun, .esun, .sinopac,
    .taipeistar
  ]

  static let apiAvaliable: [Bank] = [
    .bankoftaiwan, .landbank, .firstbank,
    .huananbank, // .changhwabank,
    .shanghaicommercialsavingbank,
    .fuban, .cathayunited, //.bankofkaosiung,
    .mega, .citi, //.anz,
    //.taiwanbusinessbank,
    .standardchartered, .taiwancooperativebank,
    .taichungbank, //.ktb,
    .hsbc,
    //.skbank, .sunnybank,
    .bankofpanhsin,
    .cotabank, //.unionbankoftaiwan, .fareasternbank,
    //.yuantabank,
    .taishin, .kgi,
    .chinatrust, .dbs, .entie,
    .jihsun, .esun, .sinopac,
    .taipeistar
  ]
}

extension Bank {
  func url(exchange: ExchangeType) -> String {
    
    //https://tw.rter.info/json.php?t=bank&q=cash&iso=SCBLTWTP
    let q = exchange.rawValue
    let iso = swiftCode
    let url = "https://tw.rter.info/json.php?t=bank&q=\(q)&iso=\(iso)"
    
    return url
  }

  var swiftCode: String {
    switch self {
    case .bankoftaiwan:
      return "BKTWTWTP"
    case .landbank:
      return "LBOTTWTP"
    case .firstbank:
      return "FCBKTWTP"
    case .huananbank:
      return "HNBKTWTP"
    case .changhwabank:
      return "CCBCTWTP"
    case .shanghaicommercialsavingbank:
      return "SCSBTWTP"
    case .fuban:
      return "TPBKTWTP"
    case .cathayunited:
      return "UWCBTWTP"
    case .bankofkaosiung:
      return "BKAOTWTK"
    case .mega:
      return "ICBCTWTP"
    case .citi:
      return "CITITWTP"
    case .anz:
      return "ANZBTWTP"
    case .taiwanbusinessbank:
      return "MBBTTWTP"
    case .standardchartered:
      return "SCBLTWTP"
    case .taiwancooperativebank:
      return "TACBTWTP"
    case .taichungbank:
      return "TCBBTWTH"
    case .ktb:
      return "TNBBTWTN"
    case .hsbc:
      return "HSBCTWTP"
    case .skbank:
      return "MKTBTWTP"
    case .sunnybank:
      return "SUNYTWTP"
    case .bankofpanhsin:
      return "BBBKTWTP"
    case .cotabank:
      return "COBKTWTP"
    case .unionbankoftaiwan:
      return "UBOTTWTP"
    case .fareasternbank:
      return "FEINTWTP"
    case .yuantabank:
      return "APBKTWTH"
    case .taishin:
      return "TSIBTWTP"
    case .kgi:
      return "CSMBTWTP"
    case .chinatrust:
      return "CTCBTWTP"
    case .dbs:
      return "DBSSTWTP"
    case .entie:
      return "ENTITWTP"
    case .jihsun:
      return "JSIBTWTP"
    case .esun:
      return "ESUNTWTP"
    case .sinopac:
      return "SINOTWTP"
    case .taipeistar:
      return "BOTPTWTP"
    }
  }

  var countryTransferCode: String {
    fatalError("not implement yet")
  }
}
