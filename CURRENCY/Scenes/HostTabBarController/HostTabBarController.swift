//
//  HostTabBarViewController.swift
//  CURRENCY
//
//  Created by Stan Liu on 25/01/2018.
//  Copyright (c) 2018 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RAMAnimatedTabBarController

protocol HostTabBarDisplayLogic: class {
  func displaySomething(viewModel: HostTabBar.Something.ViewModel)
}

class HostTabBarController: RAMAnimatedTabBarController, HostTabBarDisplayLogic, LanguageRelodable {
  var interactor: HostTabBarBusinessLogic?
  var router: (NSObjectProtocol & HostTabBarRoutingLogic & HostTabBarDataPassing)?

  // Use custom animation
  lazy var bounceAnimation: HostBounceAnimation = {
    return HostBounceAnimation()
  }()

  lazy var bankCurrencyNavi: UINavigationController = {
    guard let navigationController = R.storyboard.bankCurrency.instantiateInitialViewController() else {
      let navigationController = UINavigationController(rootViewController: BankCurrencyViewController())
      return navigationController
    }
    return navigationController
  }()

  lazy var calculatorNavi: UINavigationController = {
    guard let navigationController = R.storyboard.convertCurrency.instantiateInitialViewController() else {
      let navigationController = UINavigationController(rootViewController: ConvertCurrencyViewController())
      return navigationController
    }
    return navigationController
  }()

  lazy var listSettingNavi: UINavigationController = {
    guard let navigationController = R.storyboard.more.instantiateInitialViewController() else {
      let navigationController = UINavigationController(rootViewController: ListMoreViewController())
      return navigationController
    }
    return navigationController
  }()

  var bankCurrencyTitle: String {
    return LanguageWorker.shared.localizedString(key: R.string.uI.bank_currency_title.key,
                                                 table: .ui)
  }
    
  var calculatorTitle: String {
    return LanguageWorker.shared.localizedString(key: R.string.uI.calculator_title.key,
                                                 table: .ui)
  }
    
  var moreTitle: String {
    return LanguageWorker.shared.localizedString(key: R.string.uI.more_title.key,
                                                 table: .ui)
  }

  var exampleTitle: String {
    return LanguageWorker.shared.localizedString(key: "Example",
                                                 table: .ui)
  }
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
    let interactor = HostTabBarInteractor()
    let presenter = HostTabBarPresenter()
    let router = HostTabBarRouter()
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

  override func viewDidLoad() {
    setupBarButtonItem()
    super.viewDidLoad()

    configureTabBar()
    setupInitialTabBarIndex()
  }

  func configureTabBar() {
    let topLiner = CALayer()
    topLiner.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.3)
    topLiner.backgroundColor = Configuration.Theme.lightGray.alpha(80).cgColor
    tabBar.layer.addSublayer(topLiner)
  }

  func createTabBarItem(title: String,
                        image: UIImage?,
                        selectedImage: UIImage?) -> HostAnimatedTabBarItem {
    let _item = HostAnimatedTabBarItem(title: title,
                                       image: image,
                                       selectedImage: selectedImage)
    _item.img = image
    _item.selectedImg = selectedImage
    _item.textColor = Configuration.Theme.blue
    _item.textFontSize = 10
    _item.animation = HostBounceAnimation(tabBarItem: _item)
    return _item
  }

  // Initial BarButtonItems
  @objc dynamic func setupBarButtonItem() {
    // Hide the system tabBarItem title select or unselected.
    tabBar.tintColor = .clear
    if #available(iOS 10.0, *) {
      tabBar.unselectedItemTintColor = .clear
    } else {
      // Fallback on earlier versions
    }
    
    // assign vc tabBarItem
    bankCurrencyNavi.tabBarItem = createTabBarItem(title: bankCurrencyTitle,
                                                   image: R.image.currency_unselected(),
                                                   selectedImage: R.image.currency())
    calculatorNavi.tabBarItem = createTabBarItem(title: calculatorTitle,
                                                 image: R.image.calculator_unselected(),
                                                 selectedImage: R.image.calculator())
    listSettingNavi.tabBarItem = createTabBarItem(title: moreTitle,
                                                  image: R.image.more_unselected(),
                                                  selectedImage: R.image.more())
    viewControllers = [bankCurrencyNavi, calculatorNavi, listSettingNavi]
  }

  // Select first item when tabBarController did load (app launch)
  @objc func setupInitialTabBarIndex() {
    guard let items = tabBar.items else {
      return
    }
    for index in 1..<items.count {
      setSelectIndex(from: index, to: 0)
    }
  }

  func reloadLanguage() {
    (bankCurrencyNavi.tabBarItem as? HostAnimatedTabBarItem)?.iconView?.textLabel.text = bankCurrencyTitle
    (calculatorNavi.tabBarItem as? HostAnimatedTabBarItem)?.iconView?.textLabel.text = calculatorTitle
    (listSettingNavi.tabBarItem as? HostAnimatedTabBarItem)?.iconView?.textLabel.text = moreTitle
  }

  // MARK: Do something

  func doSomething() {
    let request = HostTabBar.Something.Request()
    interactor?.doSomething(request: request)
  }

  func displaySomething(viewModel: HostTabBar.Something.ViewModel) {
  }
}

// RAMANimatedTabBarController Setup instruction:
//   1. set UITabbarController class in storyboard.
//   2. set BarButtonItem class(either native or override one), image.
//   3. drag a object on VC or storyboard reference, set animation class.
//   4. connect RamAnimatedBarButtonItem animted to animation object.

class HostAnimatedTabBarItem: RAMAnimatedTabBarItem {
  var img: UIImage?
  var selectedImg: UIImage?
}

// Drag and Drop a object on viewController in storybaord
// set that object class a Animation class
class HostBounceAnimation: RAMItemAnimation {

  weak var tabBarItem: RAMAnimatedTabBarItem?

  init(tabBarItem: RAMAnimatedTabBarItem? = nil) {
    super.init()
    self.tabBarItem = tabBarItem
  }

  override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
    playBounceAnimation(icon)
    textLabel.textColor = Configuration.Theme.darkBlue
    guard let item = tabBarItem as? HostAnimatedTabBarItem else {
      fatalError("item selected image is nil")
    }
    icon.image = item.selectedImg
  }

  override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
    textLabel.textColor = Configuration.Theme.lightBlue
    guard let item = tabBarItem as? HostAnimatedTabBarItem else {
      fatalError("item image is nil")
    }
    icon.image = item.img
  }

  override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
    textLabel.textColor = Configuration.Theme.darkBlue
  }

  func playBounceAnimation(_ icon: UIImageView) {

    let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
    bounceAnimation.duration = TimeInterval(duration)
    bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic

    icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
  }
}
