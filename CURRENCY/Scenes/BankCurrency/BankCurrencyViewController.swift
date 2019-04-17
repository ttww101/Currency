//
//  BankCurrencyViewController.swift
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
import Hero
import PagingMenuController
import SVProgressHUD

protocol BankCurrencyDisplayLogic: class {
  func displayFetchedBankCurrencies(viewModel: BankCurrency.Fetch.ViewModel)
  func displayError(viewModel: Base.HandleError.ViewModel)
}

class BankCurrencyViewController: UIViewController,
  BankCurrencyDisplayLogic,
  LoadingControl,
  CurrencyReloadable,
  LanguageRelodable,
  UIControlControl {
  var interactor: BankCurrencyBusinessLogic?
  var router: (NSObjectProtocol & BankCurrencyRoutingLogic & BankCurrencyDataPassing)?

  // MARK: Object lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: Setup

  private func setup() {
    let viewController = self
    let interactor = BankCurrencyInteractor()
    let presenter = BankCurrencyPresenter()
    let router = BankCurrencyRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  // MARK: Routing

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }

  // MARK: View lifecycle
  var onView: LoadingContainer {
    return self.view
  }

  struct StockItem: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
      return .text(title: MenuItemText(text: LanguageWorker.shared.localizedString(key: R.string.uI.stock.key, table: .ui),
                                       color: Configuration.Theme.mediumGray,
                                       selectedColor: Configuration.Theme.textColor,
                                       font: Configuration.Font.letterFont,
                                       selectedFont: Configuration.Font.letterFont))
    }
  }
    
  struct CashItem: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
      return .text(title: MenuItemText(text: LanguageWorker.shared.localizedString(key: R.string.uI.cash.key, table: .ui),
                                       color: Configuration.Theme.mediumGray,
                                       selectedColor: Configuration.Theme.textColor,
                                       font: Configuration.Font.letterFont,
                                       selectedFont: Configuration.Font.letterFont))
    }
  }

  weak var stockVC: ListBankCurrencyViewController? {
    return self.pageMenuOptions.stockVC
  }
  weak var cashVC: ListBankCurrencyViewController? {
    return self.pageMenuOptions.cashVC
  }

  // custom page menu bar
  struct MenuOptions: MenuViewCustomizable {
    var height: CGFloat { return 40 }
    var displayMode: MenuDisplayMode { return .segmentedControl }

    var itemsOptions: [MenuItemViewCustomizable] {
      return [StockItem(), CashItem()]
    }
    var focusMode: MenuFocusMode {
      return .underline(height: 2,
                        color: Configuration.Theme.textColor,
                        horizontalPadding: 0,
                        verticalPadding: 0)
    }
  }

  // custom page menu controller type
  struct PageMenuOptions: PagingMenuControllerCustomizable {
    var stockVC: ListBankCurrencyViewController = ListBankCurrencyViewController()
    var cashVC: ListBankCurrencyViewController = ListBankCurrencyViewController()

    var componentType: ComponentType {
      return .all(menuOptions: MenuOptions(),
                  pagingControllers: [stockVC, cashVC])
    }
  }

  lazy var pageMenuOptions: PageMenuOptions = {
    return PageMenuOptions()
  }()

  // page menu root controller
  lazy var pagingMenuController: PagingMenuController = {
    return PagingMenuController(options: pageMenuOptions)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    configurePageMenu()
    configureReachability()

    fetchAll()
    self.title = LanguageWorker.shared.localizedString(key: UserSettings.source,
                                                       table: .listCurrency)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = false
  }

  func configure() {
    self.isHeroEnabled = true
    self.navigationController?.isHeroEnabled = true
    if #available(iOS 11.0, *) {
      navigationItem.largeTitleDisplayMode = .never
    } else {
      // Fallback on earlier versions
    }
    self.title = LanguageWorker.shared.localizedString(key: UserSettings.source,
                                                       table: .listCurrency)
    let editTitle = LanguageWorker.shared.localizedString(key: R.string.uI.edit.key, table: .ui)
    let editBarButtonItem = UIBarButtonItem(title: editTitle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(BankCurrencyViewController.routeToCurrencySetting))
    navigationItem.rightBarButtonItem = editBarButtonItem
    let reloadBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                              target: self,
                                              action: #selector(BankCurrencyViewController.reloadCurrency))
    navigationItem.leftBarButtonItem = reloadBarButtonItem
  }

  func configureReachability() {
    let reachabilityWorker = ReachabilityWorker.shared
    reachabilityWorker.whenReachable = { [weak self] (reachability) in
      guard reachability.connection != .none else { return }
      // Do things when connection comes back
      self?.fetchAll()
    }
    reachabilityWorker.whenUnreachable = { [weak self] (reachability) in
      // Do thins notify user has no connection currently
      self?.enable(self?.navigationItem.leftBarButtonItem)
      SVProgressHUD.showError(withStatus: NetworkError.noInternet.localizedDescription)
    }
  }

  func configurePageMenu() {
    addChild(pagingMenuController)
    view.addSubview(pagingMenuController.view)
    pagingMenuController.didMove(toParent: self)
    pageMenuOptions.stockVC.routerHandler = { (subject, imageURL, isStock, indexPath) in
      self.router?.routeToHistoryCurrency(segue: nil,
                                          subject: subject,
                                          imageURL: imageURL,
                                          isStock: isStock,
                                          indexPath: indexPath)
    }
    pageMenuOptions.cashVC.routerHandler = { (subject, imageURL, isStock, indexPath) in
      self.router?.routeToHistoryCurrency(segue: nil,
                                          subject: subject,
                                          imageURL: imageURL,
                                          isStock: isStock,
                                          indexPath: indexPath)
    }
    let finishDisplayHandler: (() -> Void) = { [unowned self] in
      self.dismissLoading()
    }
    pageMenuOptions.stockVC.finishDisplayHandler = finishDisplayHandler
    pageMenuOptions.cashVC.finishDisplayHandler = finishDisplayHandler

    pagingMenuController.onMove = { state in
      switch state {
      case let .willMoveController(menuController, _): //previousMenuController
        if let destination = menuController as? ListBankCurrencyViewController {
          if self.pagingMenuController.currentPage == 0 {
            self.router?.routeToCash(destination: destination)
          } else {
            self.router?.routeToStock(destination: destination)
          }
        }
      default:
        print("")
      }
    }
  }

  func reloadLanguage() {
    configure()
    // Reload PageMenu Title
    /// FIXME:  stephen
    
//    pagingMenuController.reload(pageMenuOptions)
    // Reload PageMenu child viewcontroller
    pagingMenuController.pagingViewController?.controllers.forEach {
      if let vc = $0 as? LanguageRelodable {
        vc.reloadLanguage()
      }
      if let vc = $0 as? CurrencyReloadable {
        vc.reloadCurrency()
      }
    }
  }

  @objc func reloadCurrency() {
    self.title = LanguageWorker.shared.localizedString(key: UserSettings.source,
                                                       table: .listCurrency)
    let request = BankCurrency.ChangeSource.Request()
    interactor?.changeBank(request: request) // get the changed bank in DataStore
    fetchAll() // then fetch data
  }

  @objc func routeToCurrencySetting() {
    router?.routeToSelectSetting(segue: nil)
  }

  // MARK: Fetch all

  func fetchAll() {
    disable(navigationItem.leftBarButtonItem)
    showLoading()
    fetchStock()
    fetchCash()
  }

  func fetchStock() {
    let request = BankCurrency.Fetch.Request(exchangeType: .stock)
    interactor?.fetchBankCurrencies(request: request)
  }

  func fetchCash() {
    let request = BankCurrency.Fetch.Request(exchangeType: .cash)
    interactor?.fetchBankCurrencies(request: request)
  }

  func displayFetchedBankCurrencies(viewModel: BankCurrency.Fetch.ViewModel) {
    dismissLoading()
    enable(navigationItem.leftBarButtonItem)
    guard let vc = viewModel.exchangeType == .stock
      ? stockVC
      : cashVC
      else { return }
    if viewModel.exchangeType == .stock {
      router?.routeToStock(destination: vc)
    } else {
      router?.routeToCash(destination: vc)
    }
  }

  func displayError(viewModel: Base.HandleError.ViewModel) {
    dismissLoading()
    enable(navigationItem.leftBarButtonItem)
    SVProgressHUD.showError(withStatus: viewModel.error.localizedDescription)
  }
}
