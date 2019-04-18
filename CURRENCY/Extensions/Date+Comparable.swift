//
//  File.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 24/01/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

extension Date {

  var isBefore30MinsBefore: Bool {
    return Date.millionSeconds(self.millionSeconds + 1800) < Date()
  }
}
