//
//  UserSettings.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 04/01/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
  static let UserSettingsLanguage = DefaultsKey<String>("user_settings_language")
  static let UserSettingsSource = DefaultsKey<String>("user_settings_source")
  static let UserSettingsCurrency = DefaultsKey<String>("user_settings_currency")
  static let UserSettingsCurrencyUnit = DefaultsKey<String>("user_settings_base_currency")
  static let UserSettingsDecimalPoint = DefaultsKey<Int>("user_settings_decimal")
  static let UserSettingsFavoriteCurrencies = DefaultsKey<[String]>("user_settings_favorite_currencies")
  static let UserSettingsHistoryPeriod = DefaultsKey<String>("user_settings_history_period")
}

/// User settings, save in plist
struct UserSettings {

  // MARK: Default

  private static let defaultLanguage = "en"
  private static let defaultDecimalPoint: Int = 3
  private static let defaultSource = "BKTWTWTP"
  private static let defaultCurrency = "usd"
  private static let defaultCurrencyUnit = "twd"
  private static let defaultFavoriteCurrencies = ["twd", "usd", "jpy", "hkd", "cny", "krw"]
  private static let defaultHistoryPeriod = Period.defaultValue.shortTitle

  // MARK: User custom

  static func language() -> String {
    let language = Defaults[DefaultsKeys.UserSettingsLanguage]
    guard language != "" else {
      // Use Device current language code first
      guard let localLanguageCode = Locale.current.languageCode else {
        // Use programatically default language if Device current language code is nil
        return UserSettings.defaultLanguage
      }
      // Some language like chinese need to append Locale.scriptCode
      guard let localScriptCode = Locale.current.scriptCode else {
        if localLanguageCode == "en" {
          return "en"
        }
        if localLanguageCode == "zh" {
          return "zh-Hant"
        }
        
        // But english is no need to use scriptCode
        return localLanguageCode
      }
      return localLanguageCode + "-" + localScriptCode
    }
    return language
  }

  // MARK: Language

  static func setLanguage(lang: String) {
    Defaults[DefaultsKeys.UserSettingsLanguage] = lang
  }

  // MARK: Decimal Point

  static func decimalPoint() -> Int {
    let point = Defaults[DefaultsKeys.UserSettingsDecimalPoint]
    guard point != 0 else {
      return UserSettings.defaultDecimalPoint
    }
    return point
  }

  static func setDecimalPoint(point: Int) {
    Defaults[DefaultsKeys.UserSettingsDecimalPoint] = point
  }

  // MARK: Bannk Source

  static var source: String {
    let source = Defaults[DefaultsKeys.UserSettingsSource]
    guard source != "" else {
      return UserSettings.defaultSource
    }
    return source
  }

  static func setSource(name: String) {
    Defaults[DefaultsKeys.UserSettingsSource] = name
  }

  // MARK: Currency

  static var currency: String {
    let currency = Defaults[DefaultsKeys.UserSettingsCurrency]
    guard currency != "" else {
      return UserSettings.defaultCurrency
    }
    return currency
  }

  static func setCurrency(name: String) {
    Defaults[DefaultsKeys.UserSettingsCurrency] = name
  }

  // MARK: Currency Unit

  static var currencyUnit: String {
    let currency = Defaults[DefaultsKeys.UserSettingsCurrencyUnit]
    guard currency != "" else {
      return UserSettings.defaultCurrencyUnit
    }
    return currency
  }

  static func setCurrencyUnit(name: String) {
    Defaults[DefaultsKeys.UserSettingsCurrencyUnit] = name
  }

  // MARK: Favorite Currencies

  static func setFavoriteCurrencies(currencies: [String]) {
    Defaults[DefaultsKeys.UserSettingsFavoriteCurrencies] = currencies
  }

  static func favoriteCurrencies() -> [String] {
    let currency = Defaults[DefaultsKeys.UserSettingsFavoriteCurrencies]
    guard currency.count > 0, !currency.isEmpty else {
      return UserSettings.defaultFavoriteCurrencies
    }
    return currency
  }

  // MARK: History Period

  static func setHistoryPeriod(name: String) {
    Defaults[DefaultsKeys.UserSettingsHistoryPeriod] = name
  }

  static func historyPeriod() -> String {
    let period = Defaults[DefaultsKeys.UserSettingsHistoryPeriod]
    guard period != "" else {
      return UserSettings.defaultHistoryPeriod
    }
    return period
  }
}
