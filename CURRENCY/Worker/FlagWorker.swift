//
//  FlagWorker.swift
//  ExchangeHelper
//
//  Created by wang on 2019/04/24.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

struct CharacterUnicodeWorker {
  static let allCharacters: [String: String] = [
    "A": "1f1e6",
    "B": "1f1e7",
    "C": "1f1e8",
    "D": "1f1e9",
    "E": "1f1ea",
    "F": "1f1eb",
    "G": "1f1ec",
    "H": "1f1ed",
    "I": "1f1ee",
    "J": "1f1ef",
    "K": "1f1f0",
    "L": "1f1f1",
    "M": "1f1f2",
    "N": "1f1f3",
    "O": "1f1f4",
    "P": "1f1f5",
    "Q": "1f1f6",
    "R": "1f1f7",
    "S": "1f1f8",
    "T": "1f1f9",
    "U": "1f1fa",
    "V": "1f1fb",
    "W": "1f1fc",
    "X": "1f1fd",
    "Y": "1f1fe",
    "Z": "1f1ff"
  ]

  func convert(from name: String, symbol: String) -> String? {
    // 1. make name uppercase
    var uppercasedName = name.uppercased()
    // 2. check if name count > 3 to prevent crash, ex: "TWD", "THB", "USD"
    guard uppercasedName.count >= 3 else { return nil }
    // 3. move last doller character, ex: "TWD" -> "TW" become country code
    uppercasedName.removeLast()
    // 4. convert character into unicode and combile them with symble, ex: U+1F1F9-U+1F1FC means "TW"
    let composed = uppercasedName.reduce("", { (result, character) -> String in
      let foundUnicode = CharacterUnicodeWorker.allCharacters.filter { (s) in
        s.key == String(describing: character)
        }.first?.value ?? ""
      return result == "" ? foundUnicode : (result + symbol + foundUnicode) // no symbol if result empty
    })
    return composed
  }
}

struct FlagWorker {
  static let allCountryCodes: [String: Set<String>] = [
    "twd": ["TW"],
    "usd": ["US"],
    "hkd": ["HK"],
    "gbp": ["GB"],
    "aud": ["AU"],
    "cad": ["CA"],
    "sgd": ["SG"],
    "chf": ["CH"],
    "jpy": ["JP"],
    "zar": ["ZA"],
    "sek": ["SE"],
    "nzd": ["NZ"],
    "thb": ["TH"],
    "php": ["PH"],
    "idr": ["ID"],
    "eur": ["EU"],
    "krw": ["KR"],
    "vnd": ["VN"],
    "myr": ["MY"],
    "cny": ["CN"],
    "cnh": ["CN"],
    "dkk": ["DK"],
    "mxn": ["MX"],
    "inr": ["IN"],
    "mop": ["MO"],
    "try": ["TR"]
  ]

  enum FlagServer {
    case twitter
    case facebook

    // to change domain url
    var domainUrl: String {
      switch self {
      case .twitter:
        return "https://twemoji.maxcdn.com/2/72x72/"
      case .facebook:
        return "https://s3-ap-northeast-1.amazonaws.com/emoji-img/v6_72/"
      }
    }
  }

  func getFlagUnicode(by name: String) -> String? {
    return CharacterUnicodeWorker().convert(from: name, symbol: "-")
  }

  func getURL(from server: FlagServer, composedUnicode: String) -> String? {
    guard composedUnicode != "" else {
      return nil
    }
    return server.domainUrl + composedUnicode + ".png"
  }
}
