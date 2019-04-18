//
//  AppDelegate.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 09/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Appirater
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
    
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Reset all NSUserDefaults if in specific condition
    resetStateIfUITesting()
    resetStateForOldSourceCode()

    // Appearance
    configureNavigationBarAppearance()
    configureBarButtonItemAppearance()
    SVProgressHUDCustomConfiguration.setup()

    // App Rate
    configureAppirater()
    

    // appLaunched(Bool:) should put the last line of didFinishLaunchingWithOptions:
    Appirater.appLaunched(true)

    return true
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    ReachabilityWorker.shared.stop()
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Network Reachability
    _ = ReachabilityWorker.shared
    Appirater.appEnteredForeground(true)
  }
}

// MARK: Appearance
extension AppDelegate {

  func configureNavigationBarAppearance() {
    UINavigationBar.appearance().tintColor = Configuration.Theme.textColor
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Configuration.Theme.textColor,
                                                        NSAttributedString.Key.font: Configuration.Font.normalTitleFont]
    if #available(iOS 11.0, *) {
      UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Configuration.Theme.textColor,
                                                                 NSAttributedString.Key.font: Configuration.Font.largeTitleFont]
    } else {
      // Fallback on earlier versions
    }
  }

  func configureBarButtonItemAppearance() {
    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Configuration.Theme.textColor,
                                                         NSAttributedString.Key.font: Configuration.Font.navigationItemFont],
                                                        for: .normal)
  }
}

// MARK: Appirater
extension AppDelegate {

  func configureAppirater() {
    // Setup Appirater
    Appirater.setAppId(Configuration.AppStore.appleID)
    Appirater.setDaysUntilPrompt(3)
    Appirater.setUsesUntilPrompt(5)
    Appirater.setSignificantEventsUntilPrompt(-1)
    Appirater.setTimeBeforeReminding(2)
   
    Appirater.setCustomAlertTitle(
        LanguageWorker.shared.localizedString(key: R.string.appiraterLocalizable.rate_title.key,
                                                                        table: .appirater))
    Appirater.setCustomAlertMessage(
        LanguageWorker.shared.localizedString(key: R.string.appiraterLocalizable.rate_message.key,
                                                                          table: .appirater))
    Appirater.setCustomAlertRateButtonTitle(
        LanguageWorker.shared.localizedString(key: R.string.appiraterLocalizable.rate_rate_btn.key,
                                                                                  table: .appirater))
    Appirater.setCustomAlertCancelButtonTitle(
        LanguageWorker.shared.localizedString(key: R.string.appiraterLocalizable.rate_cancel_btn.key,
                                                                                    table: .appirater))
    Appirater.setCustomAlertRateLaterButtonTitle(
        LanguageWorker.shared.localizedString(key: R.string.appiraterLocalizable.rate_later_btn.key,
                                                                                       table: .appirater))
  }
}

private func resetStateForOldSourceCode() {
  guard let sourceCode = UserDefaults.standard.string(forKey: "user_settings_source"),
    sourceCode == "bot" else {
    return
  }
  UserSettings.setSource(name: Bank.bankoftaiwan.swiftCode)
}

private func resetStateIfUITesting() {
  guard ProcessInfo().arguments.contains("UI-Testing") == true else { return }
  guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
  UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
}

private func resetLanguageIfUITesting(_ language: String) {
  guard ProcessInfo().arguments.contains("Snapshot-Testing") == true else { return }
  UserSettings.setLanguage(lang: language)
}
