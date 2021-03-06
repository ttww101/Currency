//
//  ListBankViewController.swift
//  CURRENCY
//
//  Created by Stan Liu on 22/03/2018.
//  Copyright (c) 2018 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListBankDisplayLogic: class {
  func displayList(viewModel: ListBank.GetList.ViewModel)
}

class ListBankViewController: UIViewController,
  ListBankDisplayLogic,
  UITableViewDelegate,
  UITableViewDataSource,
  LanguageRelodable {
  var interactor: ListBankBusinessLogic?
  var router: (NSObjectProtocol & ListBankRoutingLogic & ListBankDataPassing)?

  // MARK: Object lifecycle
  var banks: [ListBank.DisplayBank] = []
  var minBuy: String = ""
  var maxSell: String = ""
  var scrollViewBridge: UIScrollViewBridge?
//  lazy var mpAdsViewModel: MPAdsViewModel = {
//    return MPAdsViewModel(adsPosition: .fix(0),
//                          tableView: tableView,
//                          cellClass: BankCell.self,
//                          viewController: self)
//  }()

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
    let interactor = ListBankInteractor()
    let presenter = ListBankPresenter()
    let router = ListBankRouter()
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
  lazy var tableView: UITableView = {
    let _tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    return _tableView
  }()
  var allowTableViewEditing: Bool = false
  lazy var header: BankHeader = {
    guard let header = R.nib.bankHeader.firstView(owner: self) else {
      return BankHeader(frame: CGRect.zero)
    }
    return header
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureHeader()
    configureTableView()

//    mpAdsViewModel.loadAds()
  }

  func configureHeader() {
    view.addSubview(header)
    header.translatesAutoresizingMaskIntoConstraints = false
    header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    header.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    header.heightAnchor.constraint(equalToConstant: 40).isActive = true
    header.nameKey = R.string.uI.bank.key
    header.buyKey = R.string.uI.buy.key
    header.sellKey = R.string.uI.sell.key
    header.reload()
  }

  func configureTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.rowHeight = 60
    tableView.sectionFooterHeight = 40
    tableView.allowsSelection = false
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    tableView.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)

    tableView.register(R.nib.bankCell(),
                       forCellReuseIdentifier: R.reuseIdentifier.bankCell.identifier)
  }

  func reloadLanguage() {
    tableView.reloadData()
    header.reload()
  }

  // MARK: Show Data
  func showList() {
    let request = ListBank.GetList.Request()
    interactor?.getList(request: request)
  }

  func displayList(viewModel: ListBank.GetList.ViewModel) {
    banks = viewModel.displayBanks
    minBuy = viewModel.minBuy ?? ""
    maxSell = viewModel.maxSell ?? ""
    tableView.reloadData()

    guard banks.count > 0 else {
      let noData = LanguageWorker.shared.localizedString(key: R.string.uI.no_data.key,
                                                         table: .ui)
      showAnnouncement(text: noData)
      return
    }
    dismissAnnouncement()
  }


  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return banks.count
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return allowTableViewEditing
  }


  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    let sourceTitle = LanguageWorker.shared.localizedString(key: R.string.listCurrency.rter_api.key,
                                                            table: .listCurrency)
    let sourcePrefix = LanguageWorker.shared.localizedString(key: R.string.uI.source_from.key,
                                                             table: .ui)
    let sourceDescription =  sourcePrefix + " " + sourceTitle
    return sourceDescription
  }

  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    guard let footer = view as? UITableViewHeaderFooterView else { return }
    footer.textLabel?.textAlignment = .right
    footer.textLabel?.font = Configuration.Font.letterFont
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.bankCell.identifier) as? BankCell else {
      return UITableViewCell()
    }
    let bank = banks[indexPath.row]
    if let imageURL = bank.imageURL,
      let url = URL(string: imageURL) {
      cell.logoImageView.kf.setImage(with: url)
    }
    cell.nameLabel.text = LanguageWorker.shared.localizedString(key: bank.name,
                                                                table: .listCurrency)
    cell.timeLabel.text = bank.rate.lastUpdate
    cell.buyCrownView.text = bank.rate.buy.userSettingDecimal.dollarMark
    cell.sellCrownView.text = bank.rate.sell.userSettingDecimal.dollarMark
    cell.buyCrownView.isCrownShown = (bank.rate.buy == minBuy)
    cell.sellCrownView.isCrownShown = (bank.rate.sell == maxSell)
    return cell
  }
}

extension ListBankViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollViewBridge?.scrollViewDidScroll?(scrollView)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    scrollViewBridge?.scrollViewDidEndDecelerating?(scrollView)
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    scrollViewBridge?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }

  func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    scrollViewBridge?.scrollViewDidScrollToTop?(scrollView)
  }
}
