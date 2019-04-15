//
//  BankHeader.swift
//  CURRENCY
//
//  Created by Stan Liu on 22/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class BankHeader: UITableViewHeaderFooterView {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var buyLabel: UILabel!
  @IBOutlet weak var sellLabel: UILabel!

  var nameKey: String?
  var subNameKey: String?
  var buyKey: String?
  var sellKey: String?
  @IBOutlet weak var trailingSpaceLayoutConstraint: NSLayoutConstraint!
  var hasAccesscoryView: Bool = false

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }

  func configure() {
    nameLabel.font = Configuration.Font.numericFont
    timeLabel.font = Configuration.Font.numericFont
    buyLabel.font = Configuration.Font.numericFont
    sellLabel.font = Configuration.Font.numericFont

    nameLabel.textColor = Configuration.Theme.darkGray
    timeLabel.textColor = Configuration.Theme.darkGray
    buyLabel.textColor = Configuration.Theme.darkGray
    sellLabel.textColor = Configuration.Theme.darkGray
  }

  func reload() {
    hasAccesscoryView == true
      ? (trailingSpaceLayoutConstraint.constant = 60)
      : (trailingSpaceLayoutConstraint.constant = 30)
    layoutIfNeeded()
    guard
      let nameKey = nameKey,
      let subNameKey = subNameKey,
      let buyKey = buyKey,
      let sellKey = sellKey
      else { return }
    nameLabel.text = LanguageWorker.shared.localizedString(key: nameKey,
                                                                  table: .ui)
    timeLabel.text = LanguageWorker.shared.localizedString(key: subNameKey,
                                                                  table: .ui)
    buyLabel.text = LanguageWorker.shared.localizedString(key: buyKey,
                                                                 table: .ui)
    sellLabel.text = LanguageWorker.shared.localizedString(key: sellKey,
                                                                  table: .ui)
  }
}
