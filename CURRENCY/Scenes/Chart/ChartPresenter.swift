//
//  ChartPresenter.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 28/03/2018.
//  Copyright (c) 2018 Meiliang Wen. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChartPresentationLogic {
  func presentFetchedHistory(response: Chart.Fetch.Response)
}

class ChartPresenter: ChartPresentationLogic {
  weak var viewController: ChartDisplayLogic?

  // MARK: Present

  func presentFetchedHistory(response: Chart.Fetch.Response) {
    let viewModel = Chart.Fetch.ViewModel()
    viewController?.displayFetchedHistory(viewModel: viewModel)
  }
}
