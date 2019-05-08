//
//  String+RemoveSpace.swift
//  ExchangeHelper
//
//  Created by curry on 2019/04/28.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

extension String {

  var removeAllSymbol: String {
    let string = self
    return string.removeDash.removeSpace
  }

  var removeSpace: String {
    let string = self
    return string.replacingOccurrences(of: " ", with: "")
  }

  var removeDash: String {
    let string = self
    return string.replacingOccurrences(of: "-", with: "")
  }

  var takeEng: String {
    let string = self
    return string.trimmingCharacters(in: CharacterSet.alphanumerics).replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
  }
}
