//
//  AdsManager.swift
//  ExchangeHelper
//
//  Created by wang on 2019/04/24.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
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
    if calculatedCount > KKConfiguration.Ads.AdsCondition.calculatedCount {
      return true
    }
    if !KKConfiguration.Ads.AdsCondition.shouldPresentAtFirst {
      return false
    }
    // If calculate count smaller than maximum calculate count
    guard let lastShownDate = Defaults[AdsKeys.AdsShownDateString].toPreciseTime else { return true }
    let last = lastShownDate.millionSeconds
    let now = Date().millionSeconds
    return now - last > KKConfiguration.Ads.AdsCondition.fullPagePresentPeriod
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
//  AdColony.configure(withAppID: KKConfiguration.Ads.AdColony.appId,
//                     zoneIDs: [KKConfiguration.Ads.AdColony.fullPage],
//                     options: nil) { (_) in }
//}
//
//var adColonyInterstitialOpen: ((AdColonyInterstitial) -> Void)?
//
//func requestAdColony() {
//  AdColony.requestInterstitial(inZone: KKConfiguration.Ads.AdColony.fullPage,
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
