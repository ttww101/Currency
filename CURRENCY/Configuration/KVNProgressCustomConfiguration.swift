//
//  KVNProgressConfiguration.swift
//  ExchangeHelper
//
//  Created by stephen on 2019/04/26.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import SVProgressHUD

//struct KVNProgressCustomConfiguration {
//  static func setup() {
//    let kvnconfiguration = KVNProgressConfiguration()
//    kvnconfiguration.circleSize = 35
//    kvnconfiguration.statusFont = KKConfiguration.Font.letterFont
//
//    KVNProgress.setConfiguration(kvnconfiguration)
//  }
//}

struct SVProgressHUDCustomConfiguration {
  static func setup () {
    SVProgressHUD.setFont(KKConfiguration.Font.letterFont)
    SVProgressHUD.setMinimumDismissTimeInterval(2.0)
  }
}
