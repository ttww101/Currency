//
//  UIControlControl.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 2018/4/27.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit
import Foundation

protocol UIControlControl {
  func enable(_ control: Any?)
  func disable(_ control: Any?)
}

enum PropertyKey {
  static let isEnabledKey = "isEnabled"
}

extension UIControlControl {
  func setEnable(option: Bool, control: Any?) {
    if let barButtonItem = control as? UIBarButtonItem {
      barButtonItem.isEnabled = option
    } else if let button = control as? UIButton {
      button.isEnabled = option
    }
  }
  func enable(_ control: Any?) {
    setEnable(option: true, control: control)
  }
  func disable(_ control: Any?) {
    setEnable(option: false, control: control)
  }
}
