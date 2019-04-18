//
//  RecordCell.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 09/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var buyRateLabel: UILabel!
  @IBOutlet var divergenceOfBuyLabel: DivergenceLabel!
  @IBOutlet var sellRateLabel: UILabel!
  @IBOutlet var divergenceOfSellLabel: DivergenceLabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    dateLabel.font = Configuration.Font.numericFont.size(of: 13)
    buyRateLabel.font = Configuration.Font.numericFont
    divergenceOfBuyLabel.font = Configuration.Font.numericFont.size(of: 12)
    divergenceOfBuyLabel.label.adjustsFontSizeToFitWidth = true
    sellRateLabel.font = Configuration.Font.numericFont
    divergenceOfSellLabel.font = Configuration.Font.numericFont.size(of: 12)
    divergenceOfSellLabel.label.adjustsFontSizeToFitWidth = true

    dateLabel.textColor = Configuration.Theme.mediumGray
    buyRateLabel.textColor = Configuration.Theme.textColor
    sellRateLabel.textColor = Configuration.Theme.textColor
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
