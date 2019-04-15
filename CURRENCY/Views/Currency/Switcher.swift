//
//  Switcher.swift
//  CURRENCY
//
//  Created by Stan Liu on 14/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
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

//    backColor = Configuration.Theme.darkBlue
//    backBorderColor = Configuration.Theme.lightBlue
//    enabledColor = Configuration.Theme.white
//    // enabledColor, disabledColor is used for text color
//    disabledColor = Configuration.Theme.lightBlue
//    enabledBackgroundColor = Configuration.Theme.green
//    enabledBorderColor = Configuration.Theme.green
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
    //layer.borderColor = Configuration.Theme.white.cgColor
    //layer.borderWidth = 1.5
    backgroundColor = Configuration.Theme.lightBlue
    selectedBackgroundColor = Configuration.Theme.darkBlue
    titleColor = Configuration.Theme.white
    selectedTitleColor = Configuration.Theme.white
    titleFont = Configuration.Font.letterFont.size(of: 16)
  }
}
