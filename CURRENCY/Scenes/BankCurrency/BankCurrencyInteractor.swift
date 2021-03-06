//
//  BankCurrencyInteractor.swift
//  CURRENCY
//
//  Created by Stan Liu on 27/03/2018.
//  Copyright (c) 2018 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BankCurrencyBusinessLogic {
  func changeBank(request: BankCurrency.ChangeSource.Request)
  func fetchBankCurrencies(request: BankCurrency.Fetch.Request)
}

protocol BankCurrencyDataStore {
  var source: String { get set }
  var stock: BankCurrency.Bank? { get set }
  var cash: BankCurrency.Bank? { get set }
}

class BankCurrencyInteractor: BankCurrencyBusinessLogic, BankCurrencyDataStore {
  var presenter: BankCurrencyPresentationLogic?
  var worker: BankCurrencyWorker = BankCurrencyWorker()

  var source: String = UserSettings.source {
    didSet {
      stock = nil
      cash = nil
    }
  }
  var stock: BankCurrency.Bank?
  var cash: BankCurrency.Bank?

  // MARK: Fetch Bank Currency

  func changeBank(request: BankCurrency.ChangeSource.Request) {
    source = UserSettings.source
  }

  func fetchBankCurrencies(request: BankCurrency.Fetch.Request) {
    let bankCurrencies = request.exchangeType == .stock ? stock : cash
    guard let bank = bankCurrencies else { // If stock and cash has
      // Otherwise, Download it
        
      guard let rter = Rter(swiftCode: source) else { return }
      
        
      worker.fetch(rter: rter, exchange: request.exchangeType) { [weak self] (bank, error) in
        if let error = error {
          let response = Base.HandleError.Response(error: error)
          self?.presenter?.presentError(response: response)
        }
        
        guard let bank = bank else { return }
        let bankCurrencies = bank.currency.map {
          BankCurrency.Currency(name: $0.name,
                                buy: $0.buy,
                                sell: $0.sell,
                                lastUpdate: $0.lastUpdate,
                                imageURL: $0.imageURL,
                                histories: nil,
                                chartImage: nil)
        }
        let editedCurrencies = CurrencyUnitWorker().setCurrencyUnit(with: bankCurrencies).map {
          BankCurrency.Currency(name: $0.name,
                                buy: $0.buy,
                                sell: $0.sell,
                                lastUpdate: $0.lastUpdate,
                                imageURL: $0.imageURL,
                                histories: nil,
                                chartImage: nil)
        }
        let editedBank = BankCurrency.Bank(name: bank.name,
                                           swiftCode: bank.swiftCode,
                                           fee: bank.fee,
                                           imageURL: bank.imageURL,
                                           currencies: editedCurrencies)
        // Assign global if success download
        if request.exchangeType == .stock {
          self?.stock = editedBank
        } else {
          self?.cash = editedBank
        }
        let response = BankCurrency.Fetch.Response(exchangeType: request.exchangeType,
                                                   bank: editedBank)
        self?.presenter?.presentFetchedBankCurrencies(response: response)
      }
      return
    }
    let response = BankCurrency.Fetch.Response(exchangeType: request.exchangeType,
                                               bank: bank)
    presenter?.presentFetchedBankCurrencies(response: response)
  }
}
