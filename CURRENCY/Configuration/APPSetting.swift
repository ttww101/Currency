//
//  APP.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 27/02/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

enum APPSetting {
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

extension APPSetting.Preference {
  var options: [String] {
    switch self {
    case .language:
//      return ["en", "zh-Hant", "zh-Hans"]
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
      return KKUserSetting.language()
    case .source:
      return KKUserSetting.source
    case .currency:
      return KKUserSetting.currency
    case .decimal:
      return KKUserSetting.decimalPoint().stringValue
    case .period:
      return KKUserSetting.historyPeriod()
    case .unit:
      return KKUserSetting.currencyUnit
    }
  }

  // Current setting of localized string
  var currentOptionLocalizedString: String {
    switch self {
    case .language:
      return LanguageWorker.shared.localizedString(key: KKUserSetting.language(),
                                                   table: .listLanguage)
    case .source:
      return LanguageWorker.shared.localizedString(key: KKUserSetting.source,
                                                   table: .listCurrency)
    case .currency:
      return LanguageWorker.shared.localizedString(key: KKUserSetting.currency,
                                                   table: .listCurrency)
    case .decimal:
      return KKUserSetting.decimalPoint().stringValue
    case .period:
      return KKUserSetting.historyPeriod()
    case .unit:
      return LanguageWorker.shared.localizedString(key: KKUserSetting.currencyUnit,
                                                   table: .listCurrency)
    }
  }

  var applyHandler: ((String?) -> Void)? {
    switch self {
    case .language:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          KKUserSetting.setLanguage(lang: chosenOption)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .source:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          KKUserSetting.setSource(name: chosenOption)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .currency:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          KKUserSetting.setCurrency(name: chosenOption)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .decimal:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          let point = chosenOption.intValue
          KKUserSetting.setDecimalPoint(point: point)
          MyApp.shared.reloadApp(type: self)
        }
      }
    case .period:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          KKUserSetting.setHistoryPeriod(name: chosenOption)
        }
      }
    case .unit:
      return { (chosenOption) in
        if let chosenOption = chosenOption {
          KKUserSetting.setCurrencyUnit(name: chosenOption)
        }
      }
    }
  }
}

extension APPSetting.Other {
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

  func reloadApp(type: APPSetting.Preference,
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
                                    with type: APPSetting.Preference) {
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
