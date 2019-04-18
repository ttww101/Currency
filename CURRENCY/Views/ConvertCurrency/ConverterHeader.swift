//
//  ConvertCurrencyHeader.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 09/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class ConverterHeader: UITableViewHeaderFooterView {

  var exchangeType: ExchangeType = .stock
  var tradeType: TradeType = .buy

  var exchangeSwitchHandler: ((ExchangeType) -> Void)?
  var tradeSwitchHandler: ((TradeType) -> Void)?

  @IBOutlet weak var exchangeSwitcher: ExchangeSwitcher!
  @IBOutlet weak var tradeSwitcher: TradeSwitcher!

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = .white
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    exchangeSwitcher.reloadTitle()
    tradeSwitcher.reloadTitle()
  }

  @IBAction func exchangeSwitchDidChange(_ sender: Any) {
    guard let switcher = sender as? ExchangeSwitcher else {
      return
    }
    exchangeType = switcher.selectedIndex == 0 ? .stock: .cash
    exchangeSwitchHandler?(exchangeType)
  }

  @IBAction func tradeSwitchDidChange(_ sender: Any) {
    guard let switcher = sender as? TradeSwitcher else {
      return
    }
    tradeType = switcher.selectedIndex == 0 ? .buy : .sell
    tradeSwitchHandler?(tradeType)
  }

  func reloadTitles() {
    exchangeSwitcher.reloadTitle()
    tradeSwitcher.reloadTitle()
  }
}
