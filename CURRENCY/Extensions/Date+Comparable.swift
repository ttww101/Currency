//
//  File.swift
//  ExchangeHelper
//
//  Created by curry on 2019/04/28.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

extension Date {

  var isBefore30MinsBefore: Bool {
    return Date.millionSeconds(self.millionSeconds + 1800) < Date()
  }
}
