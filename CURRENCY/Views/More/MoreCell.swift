//
//  MoreCell.swift
//  ExchangeHelper
//
//  Created by dina on 2019/04/24.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var variedView: MoreVariedView!

  override func awakeFromNib() {
    super.awakeFromNib()

    nameLabel.font = KKConfiguration.Font.letterFont.size(of: 16)
  }
}
