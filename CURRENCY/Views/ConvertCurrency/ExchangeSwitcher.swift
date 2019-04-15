//
//  ExchangeSwitcher.swift
//  CURRENCY
//
//  Created by Stan Liu on 09/03/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import DGRunkeeperSwitch

class ExchangeSwitcher: DGRunkeeperSwitch {

  func reloadTitle() {
    titles = [LanguageWorker.shared.localizedString(key: R.string.uI.stock.key,
                                                    table: .ui),
              LanguageWorker.shared.localizedString(key: R.string.uI.cash.key,
                                                    table: .ui)
    ]
    layoutSubviews()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
    reloadTitle()
  }

  func setup() {
    titles = ["stock", "cash"]
    //layer.borderColor = Configuration.Theme.white.cgColor
    //layer.borderWidth = 1.5
    backgroundColor = Configuration.Theme.lightBlue
    selectedBackgroundColor = Configuration.Theme.darkBlue
    titleColor = Configuration.Theme.white
    selectedTitleColor = Configuration.Theme.white
    titleFont = Configuration.Font.letterFont.size(of: 16)
  }
}
