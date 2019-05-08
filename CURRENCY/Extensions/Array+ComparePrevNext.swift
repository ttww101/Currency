//
//  Array+ComparePreviousNext.swift
//  ExchangeHelper
//
//  Created by curry on 2019/04/28.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

extension Array {
  func compare<T>(handler: (Element, Element) -> T) -> [T] {
    guard self.count > 1 else {
      return []
    }
    var results: [T] = []
    for index in 0...self.count - 2 {
      let next = self[index + 1]
      results.append(handler(self[index], next))
    }
    return results
  }
}
