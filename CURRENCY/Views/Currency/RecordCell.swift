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
    dateLabel.font = KKConfiguration.Font.numericFont.size(of: 13)
    buyRateLabel.font = KKConfiguration.Font.numericFont
    divergenceOfBuyLabel.font = KKConfiguration.Font.numericFont.size(of: 12)
    divergenceOfBuyLabel.label.adjustsFontSizeToFitWidth = true
    sellRateLabel.font = KKConfiguration.Font.numericFont
    divergenceOfSellLabel.font = KKConfiguration.Font.numericFont.size(of: 12)
    divergenceOfSellLabel.label.adjustsFontSizeToFitWidth = true

    dateLabel.textColor = KKConfiguration.Theme.mediumGray
    buyRateLabel.textColor = KKConfiguration.Theme.textColor
    sellRateLabel.textColor = KKConfiguration.Theme.textColor
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
