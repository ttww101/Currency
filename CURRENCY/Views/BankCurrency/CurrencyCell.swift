//
//  CurrencyCell.swift
//  CURRENCY
//
//  Created by Stan Liu on 27/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import Kingfisher

class CurrencyCell: UITableViewCell, LoadingControl {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var buyLabel: UILabel!
  @IBOutlet weak var sellLabel: UILabel!
  @IBOutlet weak var logoFilter: UIView!
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var chartImageView: UIImageView!
  @IBOutlet weak var nameLabelWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var adView: AdView!

  // MARK: ReloadAnimationable
  var onView: LoadingContainer {
    return chartImageView
  }
  var indicatorView: UIView {
    return UIActivityIndicatorView(style: .gray)
  }

  var chartImage: UIImage? {
    didSet {
      guard let chartImageView = self.chartImageView else { return }
      chartImageView.image = chartImage
      dismissLoading()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
    adView.isHidden = true
  }

  func configure() {
    nameLabel.font = Configuration.Font.letterFont
    buyLabel.font = Configuration.Font.numericFont
    sellLabel.font = Configuration.Font.numericFont

    nameLabel.textColor = Configuration.Theme.darkGray
    buyLabel.textColor = Configuration.Theme.darkGray
    sellLabel.textColor = Configuration.Theme.darkGray

    buyLabel.textAlignment = NSTextAlignment.left
    sellLabel.textAlignment = NSTextAlignment.left

    logoFilter.backgroundColor = .clear
    logoFilter.layer.cornerRadius = 5
    logoFilter.layer.masksToBounds = true

    logoImageView.contentMode = .scaleAspectFit
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = ""
    buyLabel.text = ""
    sellLabel.text = ""
    logoImageView.image = R.image.picture()
    chartImageView.image = nil
  }

  func bind(displayCurrency: BankCurrency.Fetch.DisplayCurrency) {
    let name = displayCurrency.name
    logoImageView.heroID = "logoImageView:\(name)"
    chartImageView.heroID = "chartImageView:\(name)"
    nameLabel.heroID = "nameLabel:\(name)"
    nameLabel.text = LanguageWorker.shared.localizedString(key: name, table: .listCurrency)
    buyLabel.text = displayCurrency.buy.userSettingDecimal.dollarMark
    sellLabel.text = displayCurrency.sell.userSettingDecimal.dollarMark

    setFlagImage(name: displayCurrency.name, baseUrl: displayCurrency.imageURL)
  }

  func setFlagImage(name: String, baseUrl: String?) {
    let flagWorker = FlagWorker()
    guard let countryUnicode = flagWorker.getFlagUnicode(by: name),
      let twitterFlagUrlString = flagWorker.getURL(from: .twitter, composedUnicode: countryUnicode),
      let twitterFlagUrl = URL(string: twitterFlagUrlString) else {

        if let imageURL = baseUrl, let url = URL(string: imageURL) {
          logoImageView.kf.setImage(with: url,
                                    placeholder: R.image.picture(),
                                    options: [.transition(.fade(0.7))]) { (_, _, _, _) in // image, error, cache, url
          }
        }
        return
    }
    logoImageView.kf.setImage(with: twitterFlagUrl,
                              placeholder: nil,
                              options: [.transition(.fade(0.7))]) { [weak self] (image, error, _, _) in // image, error, cache, url
                                guard image == nil, error != nil else { return }

                                if let facebookFlagUrlString = flagWorker.getURL(from: .facebook, composedUnicode: countryUnicode),
                                  let facebookFlagUrl = URL(string: facebookFlagUrlString) {
                                  self?.logoImageView.kf.setImage(with: facebookFlagUrl,
                                                                 placeholder: R.image.picture(),
                                                                 options: [.transition(.fade(0.7))]) { [weak self] (image, error, _, _) in
                                                                  guard image == nil, error != nil else { return }
                                                                  self?.setFlagImage(name: "", baseUrl: baseUrl)
                                  }
                                }
    }
  }

  private func fetchStart() {
    showLoading()
  }

  private func fetchFinish() {
    dismissLoading()
  }

  func fetch(name: String, completion: @escaping ([HistoryModelize], UIImage?, Error?) -> Void) {
    fetchStart()

    API().history(source: .google(UserSettings.currencyUnit,
                                  name, Period.defaultValue)) { [weak self] (histories, error) in
      if let error = error {
        completion([], nil, error)
        self?.fetchFinish()
        return
      }
      guard let histories = histories else {
        self?.fetchFinish()
        completion([], nil, error)
        return
      }
      let decimals = histories.map { return $0.close.decimalNumber }
      let screenshooter = ScreenShooter()
      screenshooter.subjects = decimals
      screenshooter.takePhoto { (image) in
        guard let image = image else {
          self?.fetchFinish()
          completion(histories, nil, nil)
          return
        }
        self?.chartImage = image
        completion(histories, image, nil)
      }
    }
  }
}

extension CurrencyCell: MPNativeAdRendering {

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  static func nibForAd() -> UINib! {
    return R.nib.currencyCell()
  }

  func nativeMainTextLabel() -> UILabel! {
    return adView.mainTextLabel
  }

  func nativeTitleTextLabel() -> UILabel! {
    adView.isHidden = false
    adView.backgroundColor = backgroundColor
    accessoryType = .none
    return adView.titleLabel
  }

  func nativeCallToActionTextLabel() -> UILabel! {
    return adView.callToActionLabel
  }

  func nativeIconImageView() -> UIImageView! {
    return adView.logoImageView
  }
}
