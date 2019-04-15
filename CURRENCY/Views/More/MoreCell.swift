//
//  MoreCell.swift
//  CURRENCY
//
//  Created by Stan Liu on 26/02/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var variedView: MoreVariedView!

  override func awakeFromNib() {
    super.awakeFromNib()

    nameLabel.font = Configuration.Font.letterFont.size(of: 16)
  }
}
