//
//  MoreVariedView.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 26/02/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

enum MoreVariedType {
  case none, label, switcher
}

class MoreVariedView: UIView {

  lazy var label: UILabel = {
    return UILabel()
  }()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

  }

  func bind(type: MoreVariedType, content: String?) {
    guard let content = content else {
      return
    }
    switch type {
    case .none:
      print("do nothing")
    case .label:
      configureLabel(value: content)
    case .switcher:
      configureSwitcher()
    }
  }

  func configureLabel(value: String) {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.topAnchor.constraint(equalTo: topAnchor).isActive = true
    label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

    label.textAlignment = NSTextAlignment.right
    label.font = KKConfiguration.Font.letterFont.size(of: 16)
    label.textColor = KKConfiguration.Theme.lightBlue
    label.text = value
  }

  func configureSwitcher() {
  }
}
