//
//  AboutMeVC.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 27/02/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import UIKit

class AboutMeVC: UIViewController, LanguageRelodable {
  @IBOutlet weak var textLabel: UILabel!
  //@IBOutlet weak var versionLabel: UILabel!
  @IBOutlet weak var agreementLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextLabel()
  }

  func configureTextLabel() {
    textLabel.textColor = Configuration.Theme.mediumGray
    textLabel.text = LanguageWorker.shared.localizedString(key: R.string.uI.aboutme_detail.key,
                                                           table: .ui)
    //versionLabel.textColor = Configuration.Theme.mediumGray
    //versionLabel.text = VersionWorker.longVersion
    agreementLabel.textColor = Configuration.Theme.mediumGray
    agreementLabel.text = LanguageWorker.shared.localizedString(key: R.string.uI.agreement_detail.key,
                                                           table: .ui)
  }

  func reloadLanguage() {
    configureTextLabel()
  }
}
