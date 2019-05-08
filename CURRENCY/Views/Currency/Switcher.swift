//
//  Switcher.swift
//  ExchangeHelper
//
//  Created by smith on 2019/04/23.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import UIKit
import DGRunkeeperSwitch
//import RoundedSwitch

// RoundedSwitch action
//exchangeType = switcher.rightSelected == true ? .stock : .cash

//class Switcher: Switch {

//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)

//    setup()
//  }

//  func setup() {
//    backgroundColor = .clear
//    borderWidth = 1.0
//    tintColor = .white

//    backColor = KKConfiguration.Theme.darkBlue
//    backBorderColor = KKConfiguration.Theme.lightBlue
//    enabledColor = KKConfiguration.Theme.white
//    // enabledColor, disabledColor is used for text color
//    disabledColor = KKConfiguration.Theme.lightBlue
//    enabledBackgroundColor = KKConfiguration.Theme.green
//    enabledBorderColor = KKConfiguration.Theme.green
//  }
//}

class Switcher: DGRunkeeperSwitch {

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
    //layer.borderColor = KKConfiguration.Theme.white.cgColor
    //layer.borderWidth = 1.5
    backgroundColor = KKConfiguration.Theme.lightBlue
    selectedBackgroundColor = KKConfiguration.Theme.darkBlue
    titleColor = KKConfiguration.Theme.white
    selectedTitleColor = KKConfiguration.Theme.white
    titleFont = KKConfiguration.Font.letterFont.size(of: 16)
  }
}
