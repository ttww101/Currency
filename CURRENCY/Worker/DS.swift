//
//  DS.swift
//  CURRENCY
//
//  Created by Stan Liu on 2018/4/12.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

struct SequenceDiff<T> {
  var common: [(T, T)]
  var removed: [T]
  var inserted: [T]
}

struct DS {
  func diff<T>(_ first: [T], _ second: [T], compare: (T, T) -> Bool) -> SequenceDiff<T> {
    let combinations = first.compactMap { firstElement in (firstElement, second.first { secondElement in compare(firstElement, secondElement) }) }
    let common = combinations.filter { $0.1 != nil }.compactMap { ($0.0, $0.1!) }
    let removed = combinations.filter { $0.1 == nil }.compactMap { ($0.0) }
    let inserted = second.filter { secondElement in !common.contains { compare($0.0, secondElement) } }
    return SequenceDiff(common: common, removed: removed, inserted: inserted)
  }
}
