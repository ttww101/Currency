//
//  CurrencyCell.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 27/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit
import Kingfisher

class CurrencyCell: UITableViewCell, LoadingControl {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var buyLabel: UILabel!
  @IBOutlet weak var sellLabel: UILabel!
  @IBOutlet weak var logoFilter: UIView!
  @IBOutlet weak var logoImageView: UIImageView!

  var indicatorView: UIView {
    return UIActivityIndicatorView(style: .gray)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }

  func configure() {
    nameLabel.font = KKConfiguration.Font.letterFont
    buyLabel.font = KKConfiguration.Font.numericFont
    sellLabel.font = KKConfiguration.Font.numericFont

    nameLabel.textColor = KKConfiguration.Theme.darkGray
    buyLabel.textColor = KKConfiguration.Theme.darkGray
    sellLabel.textColor = KKConfiguration.Theme.darkGray

//    buyLabel.textAlignment = NSTextAlignment.left
//    sellLabel.textAlignment = NSTextAlignment.left

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
  }

  func bind(displayCurrency: BankCurrency.Fetch.DisplayCurrency) {
    let name = displayCurrency.name
    logoImageView.heroID = "logoImageView:\(name)"
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
      
    }
  }
}

