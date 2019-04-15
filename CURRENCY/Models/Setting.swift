//
//  Setting.swift
//  CURRENCY
//
//  Created by Stan Liu on 22/02/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

protocol MoreProtocol {
  var localizedKey: String { get set }
}

struct Setting {
  var type: APP.Preference
  var localizedKey: String
  var options: [String]
  var applyHandler: ((String?) -> Void)?
  var currentOption: String {
    return type.currentOption
  }
  var currentOptionLocalizedString: String {
    return type.currentOptionLocalizedString
  }

  init(_ type: APP.Preference) {
    self.type = type
    self.localizedKey = type.rawValue
    self.options = type.options
    self.applyHandler = type.applyHandler
  }
}

struct More: MoreProtocol {
  var type: APP.Other
  var localizedKey: String
  var content: String

  init(_ type: APP.Other) {
    self.type = type
    self.localizedKey = type.rawValue
    self.content = type.content
  }
}
