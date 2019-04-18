//
//  TradeSwitcher.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 09/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import DGRunkeeperSwitch

class TradeSwitcher: DGRunkeeperSwitch {

  func reloadTitle() {
    titles = [LanguageWorker.shared.localizedString(key: R.string.uI.buy.key,
                                                    table: .ui),
              LanguageWorker.shared.localizedString(key: R.string.uI.sell.key,
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
    titles = ["cash", "stock"]
    //layer.borderColor = Configuration.Theme.white.cgColor
    //layer.borderWidth = 1.5
    backgroundColor = Configuration.Theme.lightPink
    selectedBackgroundColor = Configuration.Theme.pink
    titleColor = Configuration.Theme.white
    selectedTitleColor = Configuration.Theme.white
    titleFont = Configuration.Font.letterFont.size(of: 16)
  }
}
