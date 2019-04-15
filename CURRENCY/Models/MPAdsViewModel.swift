//
//  MPAdsViewModels.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/24.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

enum MPAdsPositionType {
  case fix(Int)
  case dynamic(Int)
}

class MPAdsViewModel: NSObject, MPTableViewAdPlacerDelegate {
  var adsPosition: MPAdsPositionType = .fix(1)
  var tableView: UITableView?
  var viewController: UIViewController?
  var tableViewAdPlacer: MPTableViewAdPlacer?
  var settings: MPStaticNativeAdRendererSettings?
  var config: MPNativeAdRendererConfiguration?
  var targeting: MPNativeAdRequestTargeting?
  var positioning: MPClientAdPositioning?

  init(adsPosition: MPAdsPositionType, tableView: UITableView, cellClass: UITableViewCell.Type, viewController: UIViewController) {
    super.init()
    // Setup MPStaticNativeAdRendererSettings
    let settings = MPStaticNativeAdRendererSettings()
    settings.renderingViewClass = cellClass.self
    settings.viewSizeHandler = { (maxWidth) in
      return CGSize(width: maxWidth, height: 120)
    }
    // Setup MPNativeAdRendererConfiguration
    let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings) ?? MPNativeAdRendererConfiguration()
    config.rendererSettings = settings
    config.supportedCustomEvents = ["MPMoPubNativeCustomEvent",
                                    "FacebookNativeCustomEvent",
                                    "FlurryNativeCustomEvent",
                                    "MillennialNativeCustomEvent",
                                    "VMFiveNativeVideoCustomEvent"]
    // Setup MPClientAdPositioning
    let positioning = MPClientAdPositioning()
    switch adsPosition {
    case .fix(let row):
      positioning.addFixedIndexPath(IndexPath(row: row, section: 0))
    case .dynamic(let step):
      positioning.enableRepeatingPositions(withInterval: UInt(step))
    }
    // Setup MPTableViewAdPlacer
    let _adPlacer = MPTableViewAdPlacer(tableView: tableView,
                                        viewController: viewController,
                                        adPositioning: positioning,
                                        rendererConfigurations: [config])
    _adPlacer?.delegate = self
    // Setup Targeting
    let targeting = MPNativeAdRequestTargeting()
    targeting.desiredAssets = Set<String>(arrayLiteral: kAdMainImageKey,
                                          kAdIconImageKey,
                                          kAdCTATextKey,
                                          kAdTextKey,
                                          kAdTitleKey)
    self.adsPosition = adsPosition
    self.tableView = tableView
    self.viewController = viewController
    self.settings = settings
    self.config = config
    self.tableViewAdPlacer = _adPlacer
    self.targeting = targeting
    self.positioning = positioning
  }

  func loadAds() {
    guard ReachabilityWorker.shared.isReachable else { return } // load ad when has connection
    guard let placer = self.tableViewAdPlacer, let targeting = self.targeting else { return }
    placer.loadAds(forAdUnitID: Configuration.Ads.MoPub.AdsOfCell, targeting: targeting)
  }

  func registerAdCell(tableView: UITableView,
                      cellNib: UINib,
                      reuseIdentifier identifier: String) {
    tableView.register(cellNib,
                       forCellReuseIdentifier: identifier)
  }

  func mp_selectRow(tableView: UITableView, atIndexPath indexPath: IndexPath) {
    tableView.mp_selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }

  // MPTableViewAdPlacerDelegate

  func nativeAdWillPresentModal(for placer: MPTableViewAdPlacer!) {
    print("Table view ad placer will present modal.")
  }

  func nativeAdDidDismissModal(for placer: MPTableViewAdPlacer!) {
    print("Table view ad placer did dismiss modal.")
  }

  func nativeAdWillLeaveApplication(from placer: MPTableViewAdPlacer!) {
    print("Table view ad placer will leave application.")
  }
}
