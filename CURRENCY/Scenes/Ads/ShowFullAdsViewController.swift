//
//  ShowFullAdsViewController.swift
//  CURRENCY
//
//  Created by Stan Liu on 22/02/2018.
//  Copyright (c) 2018 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import FBAudienceNetwork

protocol ShowFullAdsDisplayLogic: class {
  func displaySomething(viewModel: ShowFullAds.Something.ViewModel)
}

class ShowFullAdsViewController: UIViewController, ShowFullAdsDisplayLogic, FBInterstitialAdDelegate {
  var interactor: ShowFullAdsBusinessLogic?
  var router: (NSObjectProtocol & ShowFullAdsRoutingLogic & ShowFullAdsDataPassing)?

  // MARK: Object lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: Setup

  private func setup() {
    let viewController = self
    let interactor = ShowFullAdsInteractor()
    let presenter = ShowFullAdsPresenter()
    let router = ShowFullAdsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  // MARK: Routing

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }

  // MARK: View lifecycle
  var interstitialAd: FBInterstitialAd?

  override func viewDidLoad() {
    super.viewDidLoad()
    doSomething()
    loadInterstitialAd()
  }

  // MARK: Do something

  func loadInterstitialAd() {
    interstitialAd = FBInterstitialAd(placementID: Configuration.Ads.Facebook.IntertitialAds.fullPage)
    interstitialAd?.delegate = self
    interstitialAd?.load()
  }

  func doSomething() {
    let request = ShowFullAds.Something.Request()
    interactor?.doSomething(request: request)
  }

  func displaySomething(viewModel: ShowFullAds.Something.ViewModel) {
    //nameTextField.text = viewModel.name
  }

  // MARK: Facebook Interstitial Ad Aelegate
  func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
    interstitialAd.show(fromRootViewController: self)
    print("FBInterstitialAd is loaded and ready to be displayed")
  }

  func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
    print("FB interstitialAd error: \(error.localizedDescription)")
  }
}
