//
//  AdsManager.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/25.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

private class AdsKeys {
  init() { }
}

extension AdsKeys {
  static let AdsShownDateString = DefaultsKey<String>("ads_shown_date_string")
}

class AdsManager: NSObject {
  static let shared = AdsManager()
  var shouldPlaceFullPageAds: Bool {
    // If user use calculator more than maximum calculate count, Should show ads
    if calculatedCount > Configuration.Ads.AdsCondition.calculatedCount {
      return true
    }
    if !Configuration.Ads.AdsCondition.shouldPresentAtFirst {
      return false
    }
    // If calculate count smaller than maximum calculate count
    guard let lastShownDate = Defaults[AdsKeys.AdsShownDateString].toPreciseTime else { return true }
    let last = lastShownDate.millionSeconds
    let now = Date().millionSeconds
    return now - last > Configuration.Ads.AdsCondition.fullPagePresentPeriod
  }

  var calculatedCount: Int = 0

  func fullPageAdsDidShow() {
    Defaults[AdsKeys.AdsShownDateString] = Date().preciseTimeStringValue
    calculatedCount = 0
  }

  func calculatorDidDisplayValue() {
    calculatedCount += 1
  }
}
//
//var adColonyInterstitial: AdColonyInterstitial?
//
//func setupAdColony() {
//  AdColony.configure(withAppID: Configuration.Ads.AdColony.appId,
//                     zoneIDs: [Configuration.Ads.AdColony.fullPage],
//                     options: nil) { (_) in }
//}
//
//var adColonyInterstitialOpen: ((AdColonyInterstitial) -> Void)?
//
//func requestAdColony() {
//  AdColony.requestInterstitial(inZone: Configuration.Ads.AdColony.fullPage,
//                               options: nil,
//                               success: { (interstitial) in
//                                interstitial.setOpen {
//                                  print("adColony interstitial opened")
//                                  self.adColonyInterstitialOpen?(interstitial)
//                                }
//                                interstitial.setClose {
//                                  print("adColony interstitial closed")
//                                }
//                                self.adColonyInterstitial = interstitial
//  }, failure: { (error) in
//    print("AdColony request interstitial error: \(error)")
//  })
//}
