//
//  HostTabBarInteractor.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 25/01/2018.
//  Copyright (c) 2018 Meiliang Wen. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HostTabBarBusinessLogic {
  func doSomething(request: HostTabBar.Something.Request)
}

protocol HostTabBarDataStore {
  //var name: String { get set }
}

class HostTabBarInteractor: HostTabBarBusinessLogic, HostTabBarDataStore {
  var presenter: HostTabBarPresentationLogic?
  var worker: HostTabBarWorker?
  //var name: String = ""

  // MARK: Do something

  func doSomething(request: HostTabBar.Something.Request) {
    worker = HostTabBarWorker()
    worker?.doSomeWork()

    let response = HostTabBar.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
