//
//  ConvertCurrencyViewController.swift
//  CURRENCY
//
//  Created by Stan Liu on 29/01/2018.
//  Copyright (c) 2018 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SVProgressHUD
import CRRefresh

protocol ConvertCurrencyDisplayLogic: class {
  func displayFetchedCurrencies(viewModel: ConvertCurrency.Fetch.ViewModel)
  func displaySwitchChange(viewModel: ConvertCurrency.Get.ViewModel)
  func displayError(viewModel: Base.HandleError.ViewModel)
  func displayEdited(viewModel: ConvertCurrency.Edit.ViewModel)
  func displayCellTextFeild(viewModel: ConvertCurrency.Calculate.ViewModel)
  func displayCellPlaceHolder(viewModel: ConvertCurrency.Calculate.ViewModel)
}

class ConvertCurrencyViewController: UIViewController,
  ConvertCurrencyDisplayLogic,
  UITableViewDelegate,
  UITableViewDataSource,
  UITextFieldDelegate,
  NetworkReachable,
  LanguageRelodable,
  CurrencyReloadable,
  LoadingControl {
  var interactor: ConvertCurrencyBusinessLogic?
  var router: (NSObjectProtocol & ConvertCurrencyRoutingLogic & ConvertCurrencyDataPassing)?

  // MARK: Object lifecycle
  var sourceKey: String = UserSettings.source
  var displayCurrencies: [ConvertCurrency.Fetch.ViewModel.DisplayCurrency] = []
  var displayResults: [String] = []
  var exchangeType: ExchangeType = .stock
  var tradeType: TradeType = .buy
  var shouldDisplayPlaceHolder = true
  var selectedCurrency: String = ""
  var previousSelectedIndexPath: IndexPath?

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
    let interactor = ConvertCurrencyInteractor()
    let presenter = ConvertCurrencyPresenter()
    let router = ConvertCurrencyRouter()
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
  lazy var switcherHeader: ConverterHeader = {
    guard let _switcherHeader = R.nib.converterHeader.firstView(owner: self) else {
      return ConverterHeader(frame: CGRect.zero)
    }
    return _switcherHeader
  }()
  @IBOutlet weak var switchersContainer: UIView!
  @IBOutlet weak var tableView: UITableView!
  var isCRRefreshing: Bool = false
  @IBOutlet weak var numberPad: NumberPad!
  weak var currentCell: ConverterCell?

  var isAppearFromEditFavorite: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    configureReachability()
//    configureSwitchers()
    configureTableView()
    configureCalculator()

    fetchData()

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if isAppearFromEditFavorite {
      selectSelectedCurrency()
    }
  }

  // MARK: Setup ReachabilityWorker

  func configureReachability() {
    let reachabilityWorker = ReachabilityWorker.shared
    reachabilityWorker.whenReachable = { [weak self] (reachability) in
      guard reachability.connection != .none else {
        return
      }
      // Do things when connection comes back
      self?.fetchData()
    }
    reachabilityWorker.whenUnreachable = { (reachability) in
      // Do thins notify user has no connection currently
      SVProgressHUD.showError(withStatus: NetworkError.noInternet.localizedDescription)
    }
  }

  func configure() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: LanguageWorker.shared.localizedString(key: R.string.uI.edit.key, table: .ui),
                                                        style: UIBarButtonItem.Style.plain,
                                                        target: self,
                                                        action: #selector(ConvertCurrencyViewController.editFavoriteCurrencies))
    let infoButton = UIButton(type: .infoDark)
    infoButton.addTarget(self,
                         action: #selector(ConvertCurrencyViewController.showInstruction),
                         for: UIControl.Event.touchUpInside)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: infoButton)
    if #available(iOS 11.0, *) {
      navigationItem.largeTitleDisplayMode = .never
    }
  }

  func configureSwitchers() {
    switchersContainer.addSubview(switcherHeader)
    switcherHeader.translatesAutoresizingMaskIntoConstraints = false
    switcherHeader.topAnchor.constraint(equalTo: switchersContainer.topAnchor).isActive = true
    switcherHeader.leftAnchor.constraint(equalTo: switchersContainer.leftAnchor).isActive = true
    switcherHeader.bottomAnchor.constraint(equalTo: switchersContainer.bottomAnchor).isActive = true
    switcherHeader.rightAnchor.constraint(equalTo: switchersContainer.rightAnchor).isActive = true
    switcherHeader.exchangeSwitchHandler = { [weak self] (exchangeType) in
      guard self?.exchangeType != exchangeType else { return }
      self?.exchangeType = exchangeType
      self?.switcherDidValueChange()
    }
    switcherHeader.tradeSwitchHandler = { [weak self] (tradeType) in
      guard self?.tradeType != tradeType else { return }
      self?.tradeType = tradeType
      self?.switcherDidValueChange()
    }
  }

  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self

    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    tableView.separatorColor = Configuration.Theme.lightBlue
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    tableView.register(R.nib.converterCell(),
                       forCellReuseIdentifier: R.reuseIdentifier.converterCell.identifier)

    // Fix iPhoneX tableview scroll to bottom jumping
    if #available(iOS 11.0, *) {
      tableView.contentInsetAdjustmentBehavior = .never
    } else {
      // Fallback on earlier versions
      automaticallyAdjustsScrollViewInsets = false
    }
  
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    // Register CRRefresh
    tableView.cr.addHeadRefresh(animator: FastAnimator()) { [unowned self] in
      self.isCRRefreshing = true
      self.fetchData()
    }
  }

  func configureCalculator() {
    // MARK: Calculator Handlers
    numberPad.receiveHandler = { [unowned self] in
      guard let currentCell = self.currentCell,
        currentCell.isTextFieldFirstEdting == false else {
          self.currentCell?.isTextFieldFirstEdting = false
          return ""
      }
      return currentCell.textField.text ?? ""
    }
    numberPad.passHandler = { [unowned self] (newValue) in
      guard let currentCell = self.currentCell else { return }
      self.shouldDisplayPlaceHolder = false
      // Detect if newValue passed by numberPad is exceeded maximum digits,
      if !currentCell.detect(content: newValue) {
        return // exceeded maxmimum digits
      }
      self.updateRterCell(content: newValue) // not exceed
    }
    numberPad.emptyHandler = { [unowned self] (newValue) in
      self.shouldDisplayPlaceHolder = true
      self.currentCell?.textField.placeholder = newValue
      self.updateRterCellPlaceHolder(content: newValue)
    }
  }

  func reloadLanguage() {
    configure()
    switcherHeader.reloadTitles()
    tableView.reloadData()
  }

  func reloadCurrency() {
    fetchData()
  }

  // To get the current editing rate
  func retrieveCurrentEdtingRate() -> String? {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return nil }
    guard displayCurrencies.count > selectedIndexPath.row else { return nil } // prevent fatal error
    let rate = tradeType == .buy
      ? (displayCurrencies[selectedIndexPath.row].buy)
      : (displayCurrencies[selectedIndexPath.row].sell)
    return rate
  }

  func selectSelectedCurrency() {
    guard
      selectedCurrency != "",
      let index = displayCurrencies.index(where: {
        return $0.name == selectedCurrency
      })
      else {
        // If no selected currency use initial indexPath
        let initialIndexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: initialIndexPath,
                            animated: false,
                            scrollPosition: .none)
        currencyCell(tableView.cellForRow(at: initialIndexPath) as? ConverterCell,
                     didSelectAt: initialIndexPath)
        return
    }
    let selectedIndexPath = IndexPath(row: index, section: 0)
    tableView.selectRow(at: selectedIndexPath,
                        animated: false,
                        scrollPosition: .none)
    currencyCell(tableView.cellForRow(at: selectedIndexPath) as? ConverterCell,
                 didSelectAt: selectedIndexPath)
  }

  // MARK: Switcher Handler
  func switcherDidValueChange() {
    let request = ConvertCurrency.Get.Request(exchangeType: exchangeType, tradeType: tradeType)
    interactor?.switchChange(request: request)
  }

  @objc func editFavoriteCurrencies() {
    // Show edit currencies view
    router?.routeToEditConvertCurrency(segue: nil)
  }

  @objc func showInstruction() {
    // Show info
    let popup = PopupInfo()
    popup.items = [PopupItem(title: R.string.uI.i_know.key, type: .normal, handler: nil)]
    popup.show()
  }

  // MARK: Fetch Data

  func fetchData() {
    if !isCRRefreshing {
      showLoading()
    }
    fetchStock()
    fetchCash()
  }

  // MARK: Interactor actions

  private func fetchStock() {
    guard let rter = Rter(swiftCode: UserSettings.source) else { return }
    let source = Source.rter(rter, .stock)
    let request = ConvertCurrency.Fetch.Request(source: source)
    interactor?.fetchCurrencies(request: request)
  }

  private func fetchCash() {
    guard let rter = Rter(swiftCode: UserSettings.source) else { return }
    let source = Source.rter(rter, .cash)
    let request = ConvertCurrency.Fetch.Request(source: source)
    interactor?.fetchCurrencies(request: request)
  }

  func reloadEditedFavorite() {
    let request = ConvertCurrency.Edit.Request(exchangeType: exchangeType)
    interactor?.reloadEditedFavorite(request: request)
  }

  func updateRterCell(content: String) {
    guard let baseRate = retrieveCurrentEdtingRate() else { return }
    let request = ConvertCurrency.Calculate.Request(tradeType: tradeType,
                                                    exchangeType: exchangeType,
                                                    subjectRate: baseRate,
                                                    content: content.cleanValue)
    interactor?.updateCellTextField(request: request)
  }

  func updateRterCellPlaceHolder(content: String) {
    guard let baseRate = retrieveCurrentEdtingRate() else { return }
    let request = ConvertCurrency.Calculate.Request(tradeType: tradeType,
                                                    exchangeType: exchangeType,
                                                    subjectRate: baseRate,
                                                    content: content)
    interactor?.updateCellPlaceHolder(request: request)
  }

  // MARK: Display From Presenter

  func displayFetchedCurrencies(viewModel: ConvertCurrency.Fetch.ViewModel) {
    displayCurrencies = viewModel.displayCurrency
    tableView.reloadData()
    selectSelectedCurrency()
    if isCRRefreshing {
      tableView.cr.endHeaderRefresh()
      isCRRefreshing = false
    } else {
      dismissLoading()
    }
  }

  // Switch changed -> Update TextField or PlaceHolder
  func displaySwitchChange(viewModel: ConvertCurrency.Get.ViewModel) {
    displayCurrencies = viewModel.displayCurrencies // Use the lastest data **** IMPORTANT ****
    guard let cell = self.currentCell else { return }
    if let text = cell.textField.text, text != "" {
      updateRterCell(content: text)
    } else {
      updateRterCellPlaceHolder(content: NumberPad.defaultValue)
    }
  }

  func displayError(viewModel: Base.HandleError.ViewModel) {
    dismissLoading()
    SVProgressHUD.showError(withStatus: viewModel.error.localizedDescription)
  }

  func displayEdited(viewModel: ConvertCurrency.Edit.ViewModel) {
    displayCurrencies = viewModel.displayEditedCurrencies
    tableView.reloadData()
    selectSelectedCurrency()
  }

  func displayCellTextFeild(viewModel: ConvertCurrency.Calculate.ViewModel) {
    displayResults = viewModel.results.map { $0.userSettingDecimal }
    let otherIndexPaths = tableView.otherIndexPathsFromSelectedRow
    tableView.reloadRows(at: otherIndexPaths, with: .none)
    guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else { return }
    tableView.scrollToRow(at: indexPathForSelectedRow, at: .middle, animated: true)
    AdsManager.shared.calculatorDidDisplayValue()
//    mpFullPageViewModel.showAds(onViewController: self) { [weak self] in
//      self?.isAppearFromEditFavorite = false
//    }
  }

  func displayCellPlaceHolder(viewModel: ConvertCurrency.Calculate.ViewModel) {
    displayResults = viewModel.results.map { $0.userSettingDecimal }
    let otherIndexPaths = tableView.otherIndexPathsFromSelectedRow
    tableView.reloadRows(at: otherIndexPaths, with: .none)
  }

  /// Actual action when cell is selected
  func currencyCell(_ cell: ConverterCell?, didSelectAt indexPath: IndexPath) {
    guard let cell = cell else { return }
    guard displayCurrencies.count > indexPath.row else { return } // prevent fatal error
    previousSelectedIndexPath = indexPath
    cell.textField.becomeFirstResponder()
    cell.isTextFieldFirstEdting = true
    currentCell = cell
    selectedCurrency = displayCurrencies[indexPath.row].name
    if shouldDisplayPlaceHolder {
      numberPad.emptyHandler?(NumberPad.defaultValue)
    } else {
      numberPad.passHandler?(cell.storedString)
    }
  }

  // MARK: UITableViewDelegate

//  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 60
//  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 30
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? ConverterCell else { return }
    if cell.textField.text == String.displayNan || cell.textField.placeholder == String.displayNan {
      cell.shake()
      tableView.deselectRow(at: indexPath, animated: false)
      guard let previousSelectedIndexPath = previousSelectedIndexPath else { return }
      tableView.selectRow(at: previousSelectedIndexPath, animated: true, scrollPosition: .middle)
      //currencyCell(previousCell, didSelectAt: previousSelectedIndexPath)
      return
    }
    currencyCell(cell, didSelectAt: indexPath)
  }

  // MARK: UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayCurrencies.count
  }

//  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//    guard let header = view as? ConverterHeader, section == 0 else { return }
//    header.exchangeSwitcher.setSelectedIndex(exchangeType == .stock ? 0 : 1,
//                                             animated: false)
//    header.tradeSwitcher.setSelectedIndex(tradeType == .buy ? 0 : 1,
//                                          animated: false)
//  }
//
//  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    guard
//      let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
//        String(describing: ConverterHeader.self)
//        ) as? ConverterHeader,
//      section == 0
//      else { return nil }
//    header.exchangeSwitchHandler = { [weak self] (exchangeType) in
//      guard self?.exchangeType != exchangeType else { return }
//      self?.exchangeType = exchangeType
//      self?.switcherDidValueChange()
//    }
//    header.tradeSwitchHandler = { [weak self] (tradeType) in
//      guard self?.tradeType != tradeType else { return }
//      self?.tradeType = tradeType
//      self?.switcherDidValueChange()
//    }
//    return header
//  }

  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    guard let subject = displayCurrencies.first else { return "" }
    let lastUpdatePrefix = LanguageWorker.shared.localizedString(key: R.string.uI.last_update_colon.key,
                                                                 table: .ui)
    let source = LanguageWorker.shared.localizedString(key: UserSettings.source, table: .listCurrency)
    let sourcePrifix = LanguageWorker.shared.localizedString(key: R.string.uI.source_from.key, table: .ui)
    return lastUpdatePrefix + subject.lastUpdate + " " + sourcePrifix + source
  }

  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    guard let footer = view as? UITableViewHeaderFooterView else { return }
    footer.textLabel?.textAlignment = .right
    footer.textLabel?.font = Configuration.Font.letterFont
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.converterCell.identifier) as? ConverterCell else {
      return UITableViewCell()
    }
    // Warning: Here should use cell.delegate not cell.textField.delegate,
    // otherwise it will set origin textfield delegate from CurrencyCell to This VC
    cell.delegate = self
    let localizedKey = displayCurrencies[indexPath.row].name.lowercased()
    cell.subjectLabel.text = LanguageWorker.shared.localizedString(key: localizedKey,
                                                                   table: .listCurrency)
    // This is for after calculate shows as text or placeholder
    cell.shouldDisplayPlaceHolder = shouldDisplayPlaceHolder
    if displayResults.count == displayCurrencies.count, cell != currentCell {
      cell.storedString = displayResults[indexPath.row]
    }
    cell.backgroundColor = indexPath.row % 2 == 0 ? Configuration.Theme.lightGray : Configuration.Theme.white
    return cell
  }

  func getCurrentCell(from textField: UITextField) -> UITableViewCell? {
    guard
      // Find visible cells
      let cells = tableView.visibleCells as? [ConverterCell],
      // Find which textfield was start edting in these cells
      let cell = cells.filter({
        return $0.textField == textField
      }).first
      else { return nil }
    return cell
  }

  // MARK: UITextFieldDelegate
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField.text == String.displayNan || textField.placeholder == String.displayNan {
      guard let cell = getCurrentCell(from: textField) else { return false }
      cell.shake()
      return false
    }
    return true
  }

  // If TextField is selected, also select tableview cell
  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let cell = getCurrentCell(from: textField) as? ConverterCell,
      let indexPath = tableView.indexPath(for: cell)
    else { return }
    // Find indexPath of specific cell
    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    // Here because tableview.selectRow(at:animated:scrollPosition:) will never trigger tableview.didSelectRow
    currencyCell(cell, didSelectAt: indexPath)
  }
}

extension UITableView {

  /// Return all IndexPaths but selected row
  var otherIndexPathsFromSelectedRow: [IndexPath] {
    // create a empty indexpath list
    var indexPaths: [IndexPath] = []
    // append tableview current indexPaths
    for index in 0..<self.numberOfRows(inSection: 0) {
      let indexPath = IndexPath(row: index, section: 0)
      indexPaths.append(indexPath)
    }
    // remove from selected row
    let otherIndexPaths = indexPaths.filter {
      return $0.row != self.indexPathForSelectedRow?.row
    }
    return otherIndexPaths
  }
}
