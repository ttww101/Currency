//
//  BankCell.swift
//  ExchangeHelper
//
//  Created by smith on 2019/05/02.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit
import Kingfisher

class BankCell: UITableViewCell {

  @IBOutlet weak var logoFilter: UIView!
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var buyCrownView: CrownView!
  @IBOutlet weak var sellCrownView: CrownView!

  @IBOutlet weak var adView: AdView!

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    subviews.forEach {
      guard let label = $0 as? UILabel else { return }
      label.text = ""
    }
    contentView.backgroundColor = .white
    logoImageView.image = R.image.picture()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configure() {
    nameLabel.font = KKConfiguration.Font.letterFont
    timeLabel.font = KKConfiguration.Font.numericFont
    buyCrownView.font = KKConfiguration.Font.numericFont
    sellCrownView.font = KKConfiguration.Font.numericFont

    nameLabel.textColor = KKConfiguration.Theme.textColor
    timeLabel.textColor = KKConfiguration.Theme.textColor
    buyCrownView.textColor = KKConfiguration.Theme.textColor
    sellCrownView.textColor = KKConfiguration.Theme.textColor

    logoFilter.backgroundColor = .clear
    logoFilter.layer.cornerRadius = 5
    logoFilter.layer.masksToBounds = true

    logoImageView.contentMode = .scaleAspectFit
  }
}
//
//extension BankCell: MPNativeAdRendering {
//
//  override func layoutSubviews() {
//    super.layoutSubviews()
//  }
//
//  static func nibForAd() -> UINib! {
//    return R.nib.bankCell()
//  }
//
//  func nativeMainTextLabel() -> UILabel! {
//    return adView.mainTextLabel
//  }
//
//  func nativeTitleTextLabel() -> UILabel! {
//    adView.isHidden = false
//    adView.backgroundColor = backgroundColor
//    accessoryType = .none
//    return adView.titleLabel
//  }
//
//  func nativeCallToActionTextLabel() -> UILabel! {
//    return adView.callToActionLabel
//  }
//
//  func nativeIconImageView() -> UIImageView! {
//    return adView.logoImageView
//  }
//}
