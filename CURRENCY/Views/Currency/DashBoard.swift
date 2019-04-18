//
//  DashBoard.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 16/11/2017.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import UIKit

class DashBoard: UIView {

  var name: String = "" {
    didSet {
      self.subjectLabel.text = name
    }
  }

  var date: String = "" {
    didSet {
      self.dateLabel.text = date
    }
  }

  var switchBtnHandler: (() -> Void)?

  @IBOutlet weak var subjectLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var buyDash: PriceDash!
  @IBOutlet weak var sellDash: PriceDash!
  @IBOutlet weak var switchBtn: UIButton!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  func setup() {
    subjectLabel.font = Configuration.Font.letterFont.size(of: 23)
    dateLabel.font = Configuration.Font.numericFont
    subjectLabel.textColor = Configuration.Theme.textColor
    dateLabel.textColor = Configuration.Theme.mediumLightBlue
    switchBtn.setImage(R.image.change(), for: .normal)
  }
  @IBAction func switchBtnDidTap(_ sender: Any) {
    switchBtnHandler?()
  }
}
