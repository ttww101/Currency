//
//  String+SliceHTMLComponent.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 22/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Foundation

extension String {
  func slice(from: String, to: String) -> String? {

    return (range(of: from)?.upperBound).flatMap { substringFrom in
      (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
        String(self[substringFrom..<substringTo])
      }
    }
  }
}

extension String {
  var isGoogleCurrency: Bool {
    return self.range(of: "[^0-9,.]", options: .regularExpression) == nil
  }
}
