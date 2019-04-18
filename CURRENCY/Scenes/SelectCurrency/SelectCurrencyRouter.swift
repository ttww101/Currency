//
//  SelectSubjectRouter.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 21/01/2018.
//  Copyright (c) 2018 Meiliang Wen. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol SelectCurrencyRoutingLogic {
  func routeToCurrency(segue: UIStoryboardSegue?)
}

protocol SelectCurrencyDataPassing {
  var dataStore: SelectCurrencyDataStore? { get }
}

class SelectCurrencyRouter: NSObject, SelectCurrencyRoutingLogic, SelectCurrencyDataPassing {
  weak var viewController: SelectCurrencyViewController?
  var dataStore: SelectCurrencyDataStore?

  // MARK: Routing

  func routeToCurrency(segue: UIStoryboardSegue?) {
    if let segue = segue {
      guard let dataStore = dataStore,
        let destinationVC = segue.destination as? CurrencyViewController,
        var destinationDS = destinationVC.router?.dataStore  else {
        return
      }
      passDataToCurrency(source: dataStore, destination: &destinationDS)
    } else {
      guard let dataStore = dataStore,
        let sourceVC = viewController,
        let destinationVC = dataStore.currencyVC,
        var destinationDS = destinationVC.router?.dataStore else {
        return
      }
      passDataToCurrency(source: dataStore, destination: &destinationDS)
      navigateToCurrency(source: sourceVC, destination: destinationVC)
    }
  }

  // MARK: Navigation

  func navigateToCurrency(source: SelectCurrencyViewController, destination: CurrencyViewController) {
    source.dismiss(animated: true) {
      // Dismiss SelectCurrencyViewController needs to update subject
      destination.fetchData(pulling: false)
    }
  }

  // MARK: Passing data

  func passDataToCurrency(source: SelectCurrencyDataStore, destination: inout CurrencyDataStore) {
  }
}
