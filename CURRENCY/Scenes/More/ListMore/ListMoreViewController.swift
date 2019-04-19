//
//  ListSettingViewController.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 22/02/2018.
//  Copyright (c) 2018 Meiliang Wen. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import MessageUI
import StoreKit
import SVProgressHUD
import MMPopupView
import Appirater

protocol ListMoreDisplayLogic: class {
  func displayFetchedSettings(viewModel: ListMore.Fetch.ViewModel)
}

class ListMoreViewController: UIViewController,
  ListMoreDisplayLogic,
  UITableViewDelegate,
  UITableViewDataSource,
  LanguageRelodable,
  MFMailComposeViewControllerDelegate {

  var interactor: ListMoreBusinessLogic?
  var router: (NSObjectProtocol & ListMoreRoutingLogic & ListMoreDataPassing)?

  // MARK: Object lifecycle
  @IBOutlet weak var tableView: UITableView!

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
    let interactor = ListMoreInteractor()
    let presenter = ListMorePresenter()
    let router = ListMoreRouter()
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
    if segue.identifier == "Agreement" {
      let agreementVC = segue.destination
      agreementVC.title = LanguageWorker.shared.localizedString(key: R.string.listSettings.agreement.key,
                                                                table: .listSettings)
    }
    if segue.identifier == "AboutMe" {
      let aboutmeVC = segue.destination
      aboutmeVC.title = LanguageWorker.shared.localizedString(key: R.string.listSettings.aboutme.key,
                                                              table: .listSettings)
    }
  }

  // MARK: View lifecycle
  var loadingView: LoadingView = LoadingView()
  var settings: [Setting] = APP.settings
  var others: [More] = APP.others

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    fetchSettings()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    reloadLanguage()
  }

  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 60
    tableView.separatorColor = KKConfiguration.Theme.lightBlue
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    tableView.register(R.nib.moreCell(), forCellReuseIdentifier: R.reuseIdentifier.moreCell.identifier)
  }

  func reloadLanguage() {
    title = LanguageWorker.shared.localizedString(key: R.string.uI.more_title.key,
                                                  table: .ui)
    tableView.reloadData()
  }

  func presentMailController() {
    let composeVC = MFMailComposeViewController()
    guard MFMailComposeViewController.canSendMail() else {
      // notify user can't send mail
      //MMAlertView(confirmTitle: "OK", detail: "Something wrong with your mail KKConfiguration").show()
      return
    }
    composeVC.mailComposeDelegate = self
    composeVC.setToRecipients(["stanwww56@gmail.com"])
    composeVC.setSubject(LanguageWorker.shared.localizedString(key: R.string.listSettings.feedback.key,
                                                               table: .listSettings))
    let device = DeviceKit.version
    let deviceCode = DeviceKit.versionCode
    let os = DeviceKit.osVersion
    let appVersion = AppKit.longVersion
    let message = "\n\n\n\nApp Version: \(appVersion)\n\(os)\nDevice: \(device)\n Device Code: \(deviceCode)\n"

    composeVC.setMessageBody(message, isHTML: false)
    present(composeVC, animated: true, completion: nil)
  }

  // MARK: Fetch settings

  func fetchSettings() {
    let request = ListMore.Fetch.Request()
    interactor?.fetchSettings(request: request)
  }

  // MARK: Display Fetched Settings

  func displayFetchedSettings(viewModel: ListMore.Fetch.ViewModel) {
    guard let settings = viewModel.settings else {
      return
    }
    self.settings = settings
    tableView.reloadData()
  }

  func showSelectSetting() {
  }

  // MARK: UITableViewDelegate

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      // Identifier must use scene name
      performSegue(withIdentifier: "SelectSetting", sender: nil)
    case 1:
      switch indexPath.row {
      case 0:
        // do feed back
        presentMailController()
      case 1:
        // do rate
        if #available(iOS 10.3, *) {
          SKStoreReviewController.requestReview()
        } else {
          // Fallback on earlier versions
          Appirater.rateApp()
        }
      case 2:
        // do about me
        performSegue(withIdentifier: "AboutMe", sender: nil)
      //case 3:
      //  // signing agreement
      //  performSegue(withIdentifier: "Agreement", sender: nil)
      default:
        print("")
      }
    default:
      print("")
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section != 2 ? 60.0 : 0.0
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return section == 2 ? 80 : 0.0
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let header = view as? MoreHeader {
      switch section {
      case 0:
        header.titleLabel.text = LanguageWorker.shared.localizedString(key: R.string.uI.settings_title.key,
                                                                       table: .ui)
      case 1:
        header.titleLabel.text = LanguageWorker.shared.localizedString(key: R.string.uI.others_title.key,
                                                                       table: .ui)
      default:
        return
      }
    }
  }

  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    if let footer = view as? MoreHeader {
      switch section {
      case 2:
        footer.titleLabel.text = LanguageWorker.shared.localizedString(key: R.string.uI.agreement_detail.key,
                                                                       table: .ui)
      default:
        return
      }
    }
  }

  // MARK: UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return settings.count
    case 1:
      return others.count
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let headerView = R.nib.moreHeader.firstView(owner: self), section != 2 else {
      return nil
    }
    headerView.contentView.backgroundColor = KKConfiguration.Theme.headerDefaultColor
    headerView.titleLabel.textAlignment = .left
    headerView.titleLabel.font = KKConfiguration.Font.largeTitleFont.size(of: 20)
    headerView.titleLabel.textColor = KKConfiguration.Theme.textColor
    return headerView
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let footerView = R.nib.moreHeader.firstView(owner: self), section == 2 else {
      return nil
    }
    //footerView.contentView.backgroundColor = KKConfiguration.Theme.headerDefaultColor
    footerView.contentView.backgroundColor = KKConfiguration.Theme.headerDefaultColor
    footerView.titleLabel.textAlignment = .left
    footerView.titleLabel.font = KKConfiguration.Font.largeTitleFont.size(of: 14)
    footerView.titleLabel.textColor = KKConfiguration.Theme.mediumGray
    return footerView
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.moreCell.identifier) as? MoreCell else {
      return UITableViewCell()
    }
    switch indexPath.section {
    case 0:
      let setting = settings[indexPath.row]
      cell.nameLabel.text = LanguageWorker.shared.localizedString(key: setting.localizedKey,
                                                                  table: .listSettings)
      cell.variedView.bind(type: .label, content: setting.currentOptionLocalizedString)
      cell.accessoryType = .disclosureIndicator
      cell.selectionStyle = .none
    case 1:
      let other = others[indexPath.row]
      cell.nameLabel.text = LanguageWorker.shared.localizedString(key: other.localizedKey,
                                                                  table: .listSettings)
      cell.variedView.bind(type: .label, content: other.content)
    default:
      print("")
    }
    return cell
  }

  // MARK: MFMailComposeDelegate

  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    switch result {
    case .sent:
      print("")
      SVProgressHUD.showSuccess(withStatus: LanguageWorker.shared.localizedString(key: R.string.listSettings.mail_sent.key,
                                                                                  table: .listSettings))
    case .saved:
      print("")
    case .cancelled:
      print("")
    case .failed:
      SVProgressHUD.showSuccess(withStatus: LanguageWorker.shared.localizedString(key: R.string.listSettings.mail_failed.key,
                                                                                  table: .listSettings))
      print("")
    }
    controller.dismiss(animated: true, completion: nil)
  }
}
