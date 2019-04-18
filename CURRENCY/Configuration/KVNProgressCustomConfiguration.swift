//
//  KVNProgressConfiguration.swift
//  ExchangeHelper
//
//  Created by Meiliang Wen on 06/03/2018.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import SVProgressHUD

//struct KVNProgressCustomConfiguration {
//  static func setup() {
//    let kvnconfiguration = KVNProgressConfiguration()
//    kvnconfiguration.circleSize = 35
//    kvnconfiguration.statusFont = Configuration.Font.letterFont
//
//    KVNProgress.setConfiguration(kvnconfiguration)
//  }
//}

struct SVProgressHUDCustomConfiguration {
  static func setup () {
    SVProgressHUD.setFont(Configuration.Font.letterFont)
    SVProgressHUD.setMinimumDismissTimeInterval(2.0)
  }
}
