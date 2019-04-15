//
//  LanguageWorker.swift
//  CURRENCY
//
//  Created by Stan Liu on 22/02/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

enum LanguageTable: String {
  case listCurrency = "ListCurrency"
  case listLanguage = "ListLanguage"
  case listSettings = "ListSettings"
  case appirater = "AppiraterLocalizable"
  case ui = "UI"
  case appError = "Error"
}

class LanguageWorker {
  static let shared = LanguageWorker()

  var currentLanguage: String {
    return UserSettings.language()
  }

  private var bundle: Bundle {
    guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
      let bundle = Bundle(path: path) else {
        return Bundle.main
    }
    return bundle
  }

  func localizedString(key: String, table: LanguageTable) -> String {

    return NSLocalizedString(key,
                             tableName: table.rawValue,
                             bundle: bundle,
                             comment: "")
  }
}
