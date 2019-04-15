//
//  MPFullPageViewModel.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/25.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class MPFullPageViewModel: NSObject, MPInterstitialAdControllerDelegate {

  static let shared = MPFullPageViewModel()
  var viewController: UIViewController?
  lazy var interstitial: MPInterstitialAdController = {
    guard let _intertitial = MPInterstitialAdController(forAdUnitId: Configuration.Ads.MoPub.fullPage)
      else { fatalError("MPIntertitialAdController init failed") }
    _intertitial.delegate = self
    return _intertitial
  }()
  private var isAdsShown: Bool = false

  override init() {
    super.init()
    loadAds()
  }

  func loadAds() {
    guard ReachabilityWorker.shared.isReachable else { return } // load ad when has connection
    if !interstitial.ready {
      interstitial.loadAd()
      isAdsShown = false
    }
  }

  func showAds(onViewController viewController: UIViewController, completion: (() -> Void)? = nil) {
    self.viewController = viewController

    if isAdsShown, interstitial.ready == false {
      loadAds()
      return
    }
    // If ready show ads
    if interstitial.ready,
      AdsManager.shared.shouldPlaceFullPageAds {
      self.interstitial.show(from: viewController)
      completion?()
    }
  }

  deinit {
    interstitial.delegate = nil
  }

  func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
  }

  func interstitialDidFail(toLoadAd interstitial: MPInterstitialAdController!) {
  }

  func interstitialWillAppear(_ interstitial: MPInterstitialAdController!) {
  }

  func interstitialDidAppear(_ interstitial: MPInterstitialAdController!) {
    isAdsShown = true
    AdsManager.shared.fullPageAdsDidShow()
  }

  func interstitialWillDisappear(_ interstitial: MPInterstitialAdController!) {
  }

  func interstitialDidDisappear(_ interstitial: MPInterstitialAdController!) {
  }

  func interstitialDidExpire(_ interstitial: MPInterstitialAdController!) {
    loadAds()
  }

  func interstitialDidReceiveTapEvent(_ interstitial: MPInterstitialAdController!) {
  }
}
