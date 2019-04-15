////
////  FBAdCell.swift
////  CURRENCY
////
////  Created by Stan Liu on 2018/4/21.
////  Copyright © 2018 Stan Liu. All rights reserved.
////
//
//import UIKit
////import MoPub
////import FBAudienceNetwork
//
//class FBAdCell: UITableViewCell {
//  @IBOutlet weak var container: UIView!
//  @IBOutlet weak var mediaContainer: UIView!
//  @IBOutlet weak var iconView: UIImageView!
//  @IBOutlet weak var titleLabel: UILabel!
//  @IBOutlet weak var bodyLabel: UILabel!
//  @IBOutlet weak var callToActionLabel: UILabel!
//
//  var mediaView: FBMediaView = FBMediaView()
//
//  override func awakeFromNib() {
//    super.awakeFromNib()
//
//    iconView.roundCorner(cornerRadius: 6)
//    iconView.layer.masksToBounds = true
//    titleLabel.textColor = Configuration.Theme.darkGray
//    titleLabel.font = Configuration.Font.letterFont
//    bodyLabel.textColor = Configuration.Theme.mediumGray
//    bodyLabel.font = Configuration.Font.letterFont
//    callToActionLabel.roundCorner(cornerRadius: 5)
//    callToActionLabel.layer.masksToBounds = true
//    callToActionLabel.backgroundColor = Configuration.Theme.darkBlue
//    callToActionLabel.font = Configuration.Font.letterFont
//    callToActionLabel.textColor = .white
//
//    //mediaContainer.addSubview(mediaView)
//    //mediaView.translatesAutoresizingMaskIntoConstraints = false
//    //let views = ["mediaView": mediaView]
//    //mediaContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mediaView]|", options: [], metrics: nil, views: views))
//    //mediaContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mediaView]|", options: [], metrics: nil, views: views))
//  }
//
//  func configCell(ad: FBNativeAd) {
////    mediaView.nativeAd = ad
////    ad.
////    titleLabel.text = ad.title ?? "ad"
////    bodyLabel.text = ad.body ?? "body"
//
//    titleLabel.text = "ad"
//    bodyLabel.text = "body"
//    callToActionLabel.text = ad.callToAction ?? ""
//    /// FIXME:  stephen
//
////    ad.icon?.loadAsync { [weak self] (image) in
////      self?.iconView.image = image
////    }
//  }
//}
//
//extension FBAdCell: MPNativeAdRendering {
//  override func layoutSubviews() {
//    super.layoutSubviews()
//  }
//
//  static func nibForAd() -> UINib! {
//    return R.nib.fbAdCell()
//  }
//
//  func nativeMainTextLabel() -> UILabel! {
//    return titleLabel
//  }
//
//  func nativeTitleTextLabel() -> UILabel! {
//    return bodyLabel
//  }
//
//  func nativeCallToActionTextLabel() -> UILabel! {
//    return callToActionLabel
//  }
//
//  func nativeIconImageView() -> UIImageView! {
//    return iconView
//  }
//}
