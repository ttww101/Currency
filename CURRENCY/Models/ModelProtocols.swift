//
//  ModelProtocols.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/10.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

protocol CarryDateBasic {
  var date: String { get set }
}
protocol CarryLastUpdate {
  var lastUpdate: String { get set }
}
protocol CarryDivergence {
  var divergence: Divergence? { get set }
}
protocol CarryImageURL {
  var imageURL: String? { get set }
}
protocol CarryFee {
  var fee: String { get set }
}

protocol HistoryBasic {
  var histories: [HistoryModelize]? { get set}
  var chartImage: UIImage? { get set }
}

protocol RateBasic {
  var amount: String { get set }
}

protocol CurrencyBasic {
  var name: String { get set }
  var buy: String { get set }
  var sell: String { get set }
}

protocol BankBasic {
  var name: String { get set }
  var swiftCode: String { get set }
}

struct RterCurrency: CurrencyBasic, CarryLastUpdate, CarryImageURL {
  var name: String
  var buy: String
  var sell: String
  var lastUpdate: String
  var imageURL: String?
}
struct RterBank<T>: BankBasic, CarryFee, CarryImageURL {
  var name: String
  var swiftCode: String
  var fee: String
  var imageURL: String?
  var currency: T
}
