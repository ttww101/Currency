//
//  AdsViewModel.swift
//  CURRENCY
//
//  Created by joe on 2019/04/27.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import FBAudienceNetwork

protocol FBAdsControl {
  var fbAdsManager: FBNativeAdsManager? { get set }
  var adTableViewCellProvider: FBNativeAdTableViewCellProvider? { get set }
  var viewController: UIViewController? { get set }
  var reloadDataHandler: (() -> Void)? { get set }
  var adRowStep: Int { get set }
  func loadAds()
  func registerAdCell(tableView: UITableView)
}

protocol FBAdsDelegate: class {
  func heightForRow(tableView: UITableView, normalHeight: CGFloat, atIndexPath indexPath: IndexPath) -> CGFloat
}

protocol FBAdsDataSource: class {
  func numberOfRow(dataCount: Int) -> Int
  func reuseNativeCellForRow(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
  func reuseAdCell(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell?
}

class FBAdsViewModel: NSObject, FBAdsControl, FBAdsDelegate, FBAdsDataSource {

  weak var viewController: UIViewController?
  var reloadDataHandler: (() -> Void)?
  var adRowStep: Int = 2

  convenience init(_ adRowStep: Int = 2, viewController: UIViewController) {
    self.init()
    self.adRowStep = adRowStep
    self.viewController = viewController
  }

  internal lazy var fbAdsManager: FBNativeAdsManager? = {
    let _fbAdsManager = FBNativeAdsManager(placementID: Configuration.Ads.Facebook.NativeAds.autoGeneric,
                                           forNumAdsRequested: 3)
    _fbAdsManager.delegate = self
    _fbAdsManager.mediaCachePolicy = FBNativeAdsCachePolicy.all
    return _fbAdsManager
  }()

  internal var adTableViewCellProvider: FBNativeAdTableViewCellProvider?

  func loadAds() {
    fbAdsManager?.loadAds()
  }

  func registerAdCell(tableView: UITableView) {
    tableView.register(R.nib.fbAdCell(),
                       forCellReuseIdentifier: R.nib.fbAdCell.name)
  }

  // MARK: FBAdsDelegate

  func heightForRow(tableView: UITableView,
                    normalHeight: CGFloat,
                    atIndexPath indexPath: IndexPath) -> CGFloat {
    guard let adTableViewCellProvider = adTableViewCellProvider,
      adTableViewCellProvider.isAdCell(at: indexPath, forStride: UInt(adRowStep))
      else {
        return normalHeight
    }
    return adTableViewCellProvider.tableView(tableView, heightForRowAt: indexPath)
  }

  // MARK: FBAdsDataSource

  func numberOfRow(dataCount: Int) -> Int {
    guard let adTableViewCellProvider = adTableViewCellProvider else {
      return dataCount
    }
    let rows = Int(adTableViewCellProvider.adjustCount(UInt(dataCount), forStride: UInt(adRowStep)))
    Debug.print(rows)
    return rows
  }

  func reuseNativeCellForRow(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
    guard let adTableViewCellProvider = adTableViewCellProvider else {
      return UITableViewCell()
    }
    return adTableViewCellProvider.tableView(tableView, cellForRowAt: indexPath)
  }

  func reuseAdCell(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell? {
    guard
      let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.fbAdCell.name,
                                               for: indexPath) as? FBAdCell,
      let adTableViewCellProvider = adTableViewCellProvider,
      adTableViewCellProvider.isAdCell(at: indexPath, forStride: UInt(adRowStep)) else { return nil }
    let nativeAd = adTableViewCellProvider.tableView(tableView, nativeAdForRowAt: indexPath)
    cell.selectionStyle = .none
    cell.configCell(ad: nativeAd)
    nativeAd.registerView(forInteraction: cell.container,
                          with: viewController,
                          withClickableViews: [cell.iconView, cell.callToActionLabel])
    return cell
  }
}

extension FBAdsViewModel: FBNativeAdsManagerDelegate {
  func nativeAdsLoaded() {
    guard let fbAdsManager = fbAdsManager else { return }
    let adTableViewCellProvider = FBNativeAdTableViewCellProvider(manager: fbAdsManager,
                                                                  for: .genericHeight120) //,
                                                                  //for: <#T##FBNativeAdViewAttributes#>)
    adTableViewCellProvider.delegate = self
    self.adTableViewCellProvider = adTableViewCellProvider
    reloadDataHandler?()
  }

  func nativeAdsFailedToLoadWithError(_ error: Error) {
    Debug.print(error)
  }
}

extension FBAdsViewModel: FBNativeAdDelegate {

  func nativeAdDidLoad(_ nativeAd: FBNativeAd) {
    //print("nativeAd did load")
    //print("FB success ads placementId: \(nativeAd.placementID)")
    nativeAd.icon?.loadAsync { (_) in // image
    }
    //print("title: \(String(describing: nativeAd.title ?? ""))")
    //print("body: \(String(describing: nativeAd.body ?? ""))")
    //print("context: \(String(describing: nativeAd.socialContext ?? ""))")
    //print("callToAction title: \(String(describing: nativeAd.callToAction ?? ""))")
  }

  func nativeAdDidClick(_ nativeAd: FBNativeAd) {
    //print("nativeAd did click")
  }

  func nativeAd(_ nativeAd: FBNativeAd, didFailWithError error: Error) {
    Debug.print("FB ads error placementId: \(nativeAd.placementID)")
    Debug.print("FB ads error: \(error)")
  }
}
