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
    //layer.borderColor = KKConfiguration.Theme.white.cgColor
    //layer.borderWidth = 1.5
    backgroundColor = KKConfiguration.Theme.lightPink
    selectedBackgroundColor = KKConfiguration.Theme.pink
    titleColor = KKConfiguration.Theme.white
    selectedTitleColor = KKConfiguration.Theme.white
    titleFont = KKConfiguration.Font.letterFont.size(of: 16)
  }
}
