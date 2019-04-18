//
//  APP.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 27/02/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

enum APP {
  // ListMore - Setting List
  static let settings = [Setting(.language),
                         Setting(.source),
                         Setting(.period),
                         //Setting(.currency), // favorite currency for old version
                         //Setting(.unit),
                         Setting(.decimal)]

  // ListMore - Other List
  static let others = [More(.feedback),
                       More(.rating),
                       More(.aboutme),
                       More(.agreement),
                       More(.version)]

  // ListMore - Setting List options
  enum Preference: String {
    case language = "language"
    case source = "default_source"
    case currency = "default_currency"
    case decimal = "decimal_point"
    case period = "default_period"
    case unit = "default_unit_currency"
  }

  enum Other: String {
    case rating
    case feedback
    case aboutme
    case agreement
    case version
  }
}

extension APP.Preference {
  var options: [String] {
    switch self {
    case .language:
      return ["en", "zh-Hant", "zh-Hans"]
    case .source:
      return Bank.apiAvaliable.map { return $0.swiftCode }
    case .currency:
      return ["twd", "usd", "hkd", "gbp", "aud", "cad", "sgd", "chf",
              "jpy", "zar", "sek", "nzd", "thb", "php", "idr", "eur",
              "krw", "vnd", "myr", "cny"]
    case .decimal:
      return ["1", "2", "3", "4"]
    case .period:
      return Period.all.map { return $0.shortTitle }
    case .unit:
      return ["twd", "usd", "hkd", "gbp", "aud", "jpy", "cny"]
    }
  }

  // Current setting of preference
  var currentOption: String {
    switch self {
    case .language:
      return UserSettings.language()
    case .source:
      return UserSettings.source
    case .currency:
      return UserSettings.currency
    case .decimal:
      return UserSettings.decimalPoint().stringValue
    case .period:
      return UserSettings.historyPeriod()
    case .unit:
      return UserSettings.currencyUnit
    }
  }

  // Current setting of localized string
  var currentOptionLocalizedString: String {
    switch self {
    case .language:
      return LanguageWorker.shared.localizedString(key: UserSettings.language(),
                                                   table: .listLanguage)
    case .source:
      return LanguageWorker.shared.localizedString(key: UserSettings.source,
                                                   table: .listCurrency)
    case .currency:
      return LanguageWorker.shared.localizedString(key: UserSettings.currency,
                                                   table: .listCurrency)
    case .decimal:
      return UserSettings.decimalPoint().stringValue
    case .period:
      return UserSettings.historyPeriod()
    case .unit:
      return LanguageWorker.shared.localizedString(key: UserSettings.currencyUnit,
                                                   table: .listCurrency)
    }
  }

  var applyHandler: ((String?) -> Void)? {
    switch self {
    case .language:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          UserSettings.setLanguage(lang: chosenOption)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .source:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          UserSettings.setSource(name: chosenOption)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .currency:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          UserSettings.setCurrency(name: chosenOption)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .decimal:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          let point = chosenOption.intValue
          UserSettings.setDecimalPoint(point: point)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .period:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          UserSettings.setHistoryPeriod(name: chosenOption)
        }
      }
    case .unit:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          UserSettings.setCurrencyUnit(name: chosenOption)
        }
      }
    }
  }
}

extension APP.Other {
  var content: String {
    switch self {
    case .rating:
      return ""
    case .feedback:
      return ""
    case .version:
      return AppKit.longVersion
    case .aboutme:
        return ""
    case .agreement:
      return ""
        
    }
  }
}
// MARK: Do App Reload

class MyApp {
  static let shared = MyApp()
  var window: UIWindow?

  func reloadApp(type: APP.Preference,
                 window: UIWindow? = UIApplication.shared.keyWindow) {
    guard let window = window,
      let rootVC = window.rootViewController else {
        print("app has no window")
        return
    }
    self.window = window
    if let navi = rootVC as? UINavigationController {
      for vc in navi.viewControllers where vc.isViewLoaded == true {
        reloadViewController(viewController: vc, with: type)
      }
    }
    if let tabBar = rootVC as? UITabBarController {
      if tabBar.isViewLoaded == true {
        reloadViewController(viewController: tabBar, with: type)
      }
      if let navis = tabBar.viewControllers as? [UINavigationController] {
        for navi in navis {
          for vc in navi.viewControllers where vc.isViewLoaded == true {
            reloadViewController(viewController: vc, with: type)
          }
        }
      }
    }
    if rootVC.isViewLoaded {
      reloadViewController(viewController: rootVC, with: type)
    }
  }

  private func reloadViewController(viewController: UIViewController,
                                    with type: APP.Preference) {
    print("reload viewController: \(String(describing: viewController.self))")
    if type == .language {
      guard let vc = viewController as? LanguageRelodable else {
        print("viewController: \(String(describing: viewController.self)) is not conformed LanguageRefreshable")
        return
      }
      vc.reloadLanguage()
    } else {
      guard let vc = viewController as? CurrencyReloadable else {
        print("viewController: \(String(describing: viewController.self)) is not conformed LanguageRefreshable")
        return
      }
      vc.reloadCurrency()
    }
  }
}
