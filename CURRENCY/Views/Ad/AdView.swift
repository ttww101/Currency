//
//  AdView.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 2018/4/26.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class AdView: UIView, XibLiveControl {
  var containerView: UIView?
  var nib: UIView? {
    return R.nib.adView.firstView(owner: self)
  }

  override var isHidden: Bool {
    didSet {
      containerView?.isHidden = isHidden
    }
  }

  @IBOutlet weak var logoFilter: UIView!
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mainTextLabel: UILabel!
  @IBOutlet weak var callToActionLabel: UILabel! {
    didSet {
      guard let width = self.callToActionLabel.text?.sizing(aliment: .center, font: Configuration.Font.letterFont).width else {
        return
      }
      actionLabelWidthConstraint.constant = max(width, 65)
    }
  }
  @IBOutlet weak var actionLabelWidthConstraint: NSLayoutConstraint!

  override init(frame: CGRect) {
    super.init(frame: frame)
    containerView = xibSetup()
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    containerView = xibSetup()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    containerView = xibSetup()
    containerView?.prepareForInterfaceBuilder()
  }

  func configure() {
    isHidden = true
    containerView?.isHidden = isHidden
    // Ads
    titleLabel.font = Configuration.Font.letterFont
    mainTextLabel.font = Configuration.Font.letterFont.size(of: 13)
    callToActionLabel.font = Configuration.Font.letterFont
    titleLabel.textColor = Configuration.Theme.textColor
    mainTextLabel.textColor = Configuration.Theme.mediumGray
    callToActionLabel.textColor = .white
    callToActionLabel.backgroundColor = Configuration.Theme.darkBlue
    callToActionLabel.roundCorner(cornerRadius: 3)
    callToActionLabel.layer.masksToBounds = true
    callToActionLabel.textAlignment = NSTextAlignment.center

    logoFilter.roundCorner(cornerRadius: 5)
    logoFilter.layer.masksToBounds = true
    logoImageView.contentMode = .scaleAspectFit
  }
}
