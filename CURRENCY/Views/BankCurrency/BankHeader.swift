//
//  BankHeader.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 22/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class BankHeader: UITableViewHeaderFooterView {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var buyLabel: UILabel!
  @IBOutlet weak var sellLabel: UILabel!

  var nameKey: String?
  var buyKey: String?
  var sellKey: String?
  var hasAccesscoryView: Bool = false

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }

  func configure() {
    nameLabel.font = KKConfiguration.Font.numericFont
    buyLabel.font = KKConfiguration.Font.numericFont
    sellLabel.font = KKConfiguration.Font.numericFont

    nameLabel.textColor = KKConfiguration.Theme.textColor
    buyLabel.textColor = KKConfiguration.Theme.textColor
    sellLabel.textColor = KKConfiguration.Theme.textColor
  }

  func reload() {
    guard
      let nameKey = nameKey,
      let buyKey = buyKey,
      let sellKey = sellKey
      else { return }
    nameLabel.text = LanguageWorker.shared.localizedString(key: nameKey,
                                                                  table: .ui)
    buyLabel.text = LanguageWorker.shared.localizedString(key: buyKey,
                                                                 table: .ui)
    sellLabel.text = LanguageWorker.shared.localizedString(key: sellKey,
                                                                  table: .ui)
  }
}
