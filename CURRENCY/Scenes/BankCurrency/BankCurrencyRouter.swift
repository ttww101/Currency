//
//  BankCurrencyRouter.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 27/03/2018.
//  Copyright (c) 2018 Meiliang Wen. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol BankCurrencyRoutingLogic {
  func routeToStock(destination: ListBankCurrencyViewController)
  func routeToCash(destination: ListBankCurrencyViewController)
  func routeToHistoryCurrency(segue: UIStoryboardSegue?,
                              subject: String,
                              imageURL: String?,
                              isStock: Bool,
                              indexPath: IndexPath)
  func routeToSelectSetting(segue: UIStoryboardSegue?)
}

protocol BankCurrencyDataPassing {
  var dataStore: BankCurrencyDataStore? { get }
}

class BankCurrencyRouter: NSObject, BankCurrencyRoutingLogic, BankCurrencyDataPassing {
  weak var viewController: BankCurrencyViewController?
  var dataStore: BankCurrencyDataStore?

  func routeToStock(destination: ListBankCurrencyViewController) {
    guard
      let sourceDS = dataStore,
      var destinationDS = destination.router?.dataStore
      else { return }
    passDataToListBankCurrency(exchange: .stock,
                               source: sourceDS,
                               destination: &destinationDS)
    destination.fetchCurrencyList()
  }

  func routeToCash(destination: ListBankCurrencyViewController) {
    guard
      let sourceDS = dataStore,
      var destinationDS = destination.router?.dataStore
      else { return }
    passDataToListBankCurrency(exchange: .cash,
                               source: sourceDS,
                               destination: &destinationDS)
    destination.fetchCurrencyList()
  }

  func routeToHistoryCurrency(segue: UIStoryboardSegue?,
                              subject: String,
                              imageURL: String?,
                              isStock: Bool,
                              indexPath: IndexPath) {
    if let segue = segue {
      guard let destinationVC = segue.destination as? HistoryCurrencyViewController,
        var destinationDS = destinationVC.router!.dataStore,
        let sourceDS = dataStore else { return }
      passDataToHistoryCurrnecy(source: sourceDS, destination: &destinationDS)
    } else {
      guard
        let destinationVC = R.storyboard.bankCurrency.historyCurrencyViewController(),
        var destinationDS = destinationVC.router?.dataStore,
        let sourceDS = dataStore,
        let sourceVC = viewController else { return }
      //passDataToHistoryCurrnecy(source: dataStore, destination: &destinationDS)
      destinationDS.name = subject
      let histories = isStock == false
        ? sourceDS.cash?.currencies[indexPath.row].histories
        : sourceDS.stock?.currencies[indexPath.row].histories
      destinationDS.historiesStorage.histories3M = histories
      navigateToHistoryCurrency(source: sourceVC, destination: destinationVC)
    }
  }

  func routeToSelectSetting(segue: UIStoryboardSegue?) {
    if let segue = segue {
      guard let dataStore = dataStore,
        let destinationVC = segue.destination as? SelectSettingViewController,
        var destinationDS = destinationVC.router?.dataStore else {
          return
      }
      passDataToSelectSetting(source: dataStore, destination: &destinationDS)
    } else {
      guard let viewController = viewController,
        let dataStore = dataStore,
        let destinationVC = R.storyboard.more.selectSettingViewController(),
        var destinationDS = destinationVC.router?.dataStore else {
          return
      }
      passDataToSelectSetting(source: dataStore, destination: &destinationDS)
      navigateToSelectSetting(source: viewController, destination: destinationVC)
    }
  }

  // MARK: Navigation

  func navigateToHistoryCurrency(source: BankCurrencyViewController, destination: HistoryCurrencyViewController) {
    source.show(destination, sender: nil)
  }

  func navigateToSelectSetting(source: BankCurrencyViewController,
                               destination: SelectSettingViewController) {
    source.show(destination, sender: nil)
  }

  // MARK: Passing data

  func passDataToListBankCurrency(exchange: ExchangeType,
                                  source: BankCurrencyDataStore,
                                  destination: inout ListBankCurrencyDataStore) {
    destination.exchange = exchange
    exchange == .cash
      ? (destination.bank = source.cash)
      : (destination.bank = source.stock)
    destination.parentVC = viewController
  }

  func passDataToHistoryCurrnecy(source: BankCurrencyDataStore, destination: inout HistoryCurrencyDataStore) {
  }

  func passDataToSelectSetting(source: BankCurrencyDataStore,
                               destination: inout SelectSettingDataStore) {
    let setting = Setting(.source)
    destination.setting = setting
  }
}
