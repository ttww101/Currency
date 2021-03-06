//
//  CurrencyRouter.swift
//  CURRENCY
//
//  Created by Stan Liu on 09/11/2017.
//  Copyright (c) 2017 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CurrencyRoutingLogic {
  func routeToSelectCurrency(segue: UIStoryboardSegue?)
  func routeToTWBank(segue: UIStoryboardSegue?)
}

protocol CurrencyDataPassing {
  var dataStore: CurrencyDataStore? { get }
}

class CurrencyRouter: NSObject, CurrencyRoutingLogic, CurrencyDataPassing {
  weak var viewController: CurrencyViewController?
  var dataStore: CurrencyDataStore?

  // MARK: Routing

  func routeToSelectCurrency(segue: UIStoryboardSegue?) {
    let destinationVC = SelectCurrencyViewController()
    guard let dataStore = dataStore,
      let viewController = viewController,
      var destinationDS = destinationVC.router?.dataStore else {
        return
    }
    passDataToSelectCurrency(source: dataStore, destination: &destinationDS)
    navigateToSelectCurrency(source: viewController, destination: destinationVC)
  }

  // MARK: Navigation

  func navigateToSelectCurrency(source: CurrencyViewController,
                                destination: SelectCurrencyViewController) {
    source.present(destination, animated: true, completion: nil)
  }

  // MARK: Passing data

  func passDataToSelectCurrency(source: CurrencyDataStore,
                                destination: inout SelectCurrencyDataStore) {
    destination.currencyVC = viewController
  }

  func routeToTWBank(segue: UIStoryboardSegue?) {
    if let segue = segue {
      guard let dataStore = dataStore,
        let sourceVC = viewController,
        let destinationVC = segue.destination as? TWBankViewController,
        var destinationDS = destinationVC.router?.dataStore else {
          return
      }
      passDataToTWBank(source: dataStore, destination: &destinationDS)
      navigateToTWBank(source: sourceVC, destination: destinationVC)
    }
  }

  func navigateToTWBank(source: CurrencyViewController,
                        destination: TWBankViewController) {

  }

  func passDataToTWBank(source: CurrencyDataStore,
                        destination: inout TWBankDataStore) {

    guard let name = source.investmentSubject?.name else { return }
    destination.title = name
  }
}
