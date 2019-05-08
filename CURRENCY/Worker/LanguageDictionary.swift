//
//  LanguageDictionary.swift
//  ExchangeHelper
//
//  Created by wang on 2019/04/24.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

struct LanguageDictionary {

  static let allCurrencies: [String: Set<String>] = [
    "twd": ["TWD", "新台", "新臺", "新台幣", "台幣", "臺幣", "新臺幣"],
    "usd": ["USD", "美", "美金", "美元", "美圓"],
    "hkd": ["HKD", "港", "港幣", "港元"],
    "gbp": ["GBP", "英", "英鎊"],
    "aud": ["AUD", "澳", "澳幣", "澳元"],
    "cad": ["CAD", "加", "加拿大", "加幣", "加拿大幣"],
    "sgd": ["SGD", "新加坡", "新幣", "新加坡幣"],
    "chf": ["CHF", "瑞士", "瑞士法郎"],
    "jpy": ["JPY", "日", "日元", "日幣", "日圓"],
    "zar": ["ZAR", "南非", "南非蘭特"],
    "sek": ["SEK", "瑞典", "瑞典幣"],
    "nzd": ["NZD", "紐", "紐幣", "紐西蘭幣"],
    "thb": ["THB", "泰", "泰銖"],
    "php": ["PHP", "菲律賓披索", "菲律賓比索"],
    "idr": ["IDR", "印尼", "印尼盾"],
    "eur": ["EUR", "歐洲", "歐元"],
    "krw": ["KRW", "韓國", "韓元", "韓圓", "韓幣"],
    "vnd": ["VND", "越南", "越南盾"],
    "myr": ["MYR", "馬來幣", "馬來西亞", "馬幣", "馬來西亞幣"],
    "cny": ["CNY", "人民幣"],
    "cnh": ["CNH", "離岸人民幣"],
    "dkk": ["DKK", "丹麥克朗", "克朗"],
    "mxn": ["MXN", "墨西哥披索", "墨西哥比索"],
    "inr": ["INR", "盧比", "印度盧比"],
    "mop": ["MOP", "澳門", "澳門幣"],
    "try": ["TRY", "土耳其里拉", "土耳其", "里拉"]
  ]

  static let allBanks: [String: Set<String>] = [
    Bank.bankoftaiwan.swiftCode: ["台灣銀行", "臺灣銀行"],
    Bank.landbank.swiftCode: ["土地銀行"],
    Bank.firstbank.swiftCode: ["第一銀行"],
    Bank.huananbank.swiftCode: ["華南銀行"],
    Bank.changhwabank.swiftCode: ["彰化銀行"],
    Bank.shanghaicommercialsavingbank.swiftCode: ["上海商銀"],
    Bank.fuban.swiftCode: ["台北富邦"],
    Bank.cathayunited.swiftCode: ["國泰世華"],
    Bank.bankofkaosiung.swiftCode: ["高雄銀行"],
    Bank.mega.swiftCode: ["兆豐商銀"],
    Bank.citi.swiftCode: ["花旗台灣"],
    Bank.anz.swiftCode: ["澳盛銀行"],
    Bank.taiwanbusinessbank.swiftCode: ["台灣中小企業銀行", "台灣企銀", "臺灣企銀"],
    Bank.standardchartered.swiftCode: ["渣打銀行"],
    Bank.taiwancooperativebank.swiftCode: ["合作金庫"],
    Bank.taichungbank.swiftCode: ["台中銀行"],
    Bank.ktb.swiftCode: ["京城商銀", "京城銀行"],
    Bank.hsbc.swiftCode: ["滙豐台灣", "滙豐銀行"],
    Bank.skbank.swiftCode: ["新光銀行"],
    Bank.sunnybank.swiftCode: ["陽信銀行"],
    Bank.bankofpanhsin.swiftCode: ["板信銀行"],
    Bank.cotabank.swiftCode: ["三信商銀"],
    Bank.unionbankoftaiwan.swiftCode: ["聯邦商銀", "聯邦銀行"],
    Bank.fareasternbank.swiftCode: ["遠東商銀"],
    Bank.yuantabank.swiftCode: ["元大商銀"],
    Bank.taishin.swiftCode: ["台新銀行"],
    Bank.kgi.swiftCode: ["凱基銀行"],
    Bank.chinatrust.swiftCode: ["中國信託"],
    Bank.dbs.swiftCode: ["星展銀行"],
    Bank.entie.swiftCode: ["安泰商銀"],
    Bank.jihsun.swiftCode: ["日盛銀行"],
    Bank.esun.swiftCode: ["玉山銀行"],
    Bank.sinopac.swiftCode: ["永豐銀行"],
    Bank.taipeistar.swiftCode: ["瑞興銀行"]
  ]

  func getCurrencyLocalizedKey(from content: String) -> String? {
    return getLocalizedKey(from: content,
                           storage: LanguageDictionary.allCurrencies)
  }

  func getBankLocalizedKey(from content: String) -> String? {
    return getLocalizedKey(from: content,
                           storage: LanguageDictionary.allBanks)
  }

  private func getLocalizedKey(from content: String, storage: [String: Set<String>]) -> String? {

    return storage.compactMap {
      // if values contains return key
      // old method needs to equal 100% of characters.
      $0.1.contains(content) ? $0.0 : nil // contains if for Set

      // new method if content contains part of values
      //$0.1.filter({ (string) -> Bool in
      //  content.contains(string) // contains if for string
      //  }).count > 0 ? $0.0 : nil

      }.first
  }
}

// slower
//func getLocalizedKey(from content: String) -> String? {
//  return LanguageDictionary.allCurrencies.keys.filter {
//    guard
//      let values = LanguageDictionary.allCurrencies[$0],
//      values.filter({
//        //return $0 == content || $0.contains(content) // is equal or contains
//        return $0.contains(content) // is equal or contains
//      }).count > 0
//      else { return false } // either values is nil, either nor filter count is zero
//    // content match
//    return true
//    }.first // return key or nil
//}
