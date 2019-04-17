//
//  PriceDash.swift
//  CURRENCY
//
//  Created by Stan Liu on 16/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import UIKit

class PriceDash: UIView {

  var name: String = "" {
    didSet {
      nameLabel.text = name
    }
  }

  var rate: String = "" {
    didSet {
      ratesLabel.text = rate
    }
  }

  var divergence: Divergence? {
    didSet {
      guard let divergence = self.divergence else {
        return
      }
      divergenceLabel.bind(tendency: divergence.tendency,
                           amountString: divergence.amount)
    }
  }

  private var nameLabel: UILabel!
  private var ratesLabel: UILabel!
  private var divergenceLabel: DivergenceLabel!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.backgroundColor = .clear
    setupLabels()
    setupConstraints()
  }

  func setupLabels() {
    nameLabel = UILabel()
    ratesLabel = UILabel()
    divergenceLabel = DivergenceLabel()

    nameLabel.font = Configuration.Font.letterFont
    ratesLabel.font = Configuration.Font.numericFont.size(of: 28)
    nameLabel.textColor = Configuration.Theme.mediumLightBlue
    ratesLabel.textColor = Configuration.Theme.textColor
    ratesLabel.adjustsFontSizeToFitWidth = true
    ratesLabel.textAlignment = NSTextAlignment.right
    divergenceLabel.font = Configuration.Font.numericFont.size(of: 12)
    divergenceLabel.label.adjustsFontSizeToFitWidth = true

    addSubview(nameLabel)
    addSubview(ratesLabel)
    addSubview(divergenceLabel)
  }

  func setupConstraints() {
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    ratesLabel.translatesAutoresizingMaskIntoConstraints = false
    divergenceLabel.translatesAutoresizingMaskIntoConstraints = false

    nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    //nameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true

    ratesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
    ratesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 3).isActive = true
    ratesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

    divergenceLabel.topAnchor.constraint(equalTo: ratesLabel.topAnchor, constant: 0).isActive = true
    divergenceLabel.leftAnchor.constraint(equalTo: ratesLabel.rightAnchor, constant: 3).isActive = true
    divergenceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -3).isActive = true
    divergenceLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true

    ratesLabel.setContentHuggingPriority(UILayoutPriority.init(249), for: .horizontal)
    ratesLabel.setContentCompressionResistancePriority(UILayoutPriority.init(749), for: .horizontal)
    divergenceLabel.setContentHuggingPriority(UILayoutPriority.init(251), for: .horizontal)
    divergenceLabel.setContentCompressionResistancePriority(UILayoutPriority.init(751), for: .horizontal)
  }
}
