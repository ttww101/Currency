//
//  DataManager.swift
//  CURRENCY
//
//  Created by Stan Liu on 02/02/2018.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation
import Disk

/// Local Currency Source Manager
struct DataManager {

  func path() {
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    print(Disk.Directory.documents.pathDescription)
  }

  func saveAll(source: Source, currencySource: CurrencySource) {
    do {
      try Disk.save(currencySource,
                    to: .documents,
                    as: "\(Configuration.Storage.sourceDirectoryPath)/\(source.name)/all.json")
    } catch let error {
      print("save source: \(source.name) error: \(error.localizedDescription)")
    }
  }

  func loadAll(source: Source) -> CurrencySource? {
    do {
      return try Disk.retrieve("\(Configuration.Storage.sourceDirectoryPath)/\(source.name)/all.json",
        from: .documents,
        as: CurrencySource.self)
    } catch let error {
      print("retrive source: \(source.name) error: \(error.localizedDescription)")
      return nil
    }
  }

  func save(source: Source, currency: InvestmentSubject) {
    do {
      try Disk.save(currency,
                    to: .documents,
                    as: "\(Configuration.Storage.sourceDirectoryPath)/\(source.name)/\(currency.name).json")
    } catch let error {
      print("save source: \(source.name) error: \(error.localizedDescription)")
    }
  }

  func load(source: Source) -> CurrencySource? {
    var investmentSubjects: [InvestmentSubject] = []
    Source.Currency.all.forEach { (element) in
      do {
        let investSubject = try Disk.retrieve("\(Configuration.Storage.sourceDirectoryPath)/\(source.name)/\(element).json",
          from: .documents,
          as: InvestmentSubject.self)
        investmentSubjects.append(investSubject)
      } catch let error {
        print("retrive: \(source.name)/\(element) error: \(error.localizedDescription)")
      }
    }
    guard investmentSubjects.count > 0 else {
      return nil
    }
    return CurrencySource(name: source.name, currencies: investmentSubjects)
  }
}
