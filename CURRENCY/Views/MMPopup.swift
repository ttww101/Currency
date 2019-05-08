//
//  MMPopup.swift
//  ExchangeHelper
//
//  Created by wang on 2019/04/26.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import MMPopupView

class PopupItem {
  var titleKey: String = ""
  var type: MMItemType = .normal
  var handler: MMPopupItemHandler?
  init(title: String, type: MMItemType, handler: MMPopupItemHandler?) {
    self.titleKey = title
    self.type = type
    self.handler = handler
  }
}

class PopupInfo {

  var items: [PopupItem] = []
  var alertView: MMAlertView?

    func show(with key: String) {
//    let title = LanguageWorker.shared.localizedString(key: R.string.uI.title.key,
//                                                      table: .ui)
        let detail = LanguageWorker.shared.localizedString(key: key,
                                                           table: .ui)
        
    let items: [MMPopupItem] = self.items.map {
      let title = LanguageWorker.shared.localizedString(key: $0.titleKey,
                                                        table: .ui)
      return MMItemMake(title, $0.type, $0.handler)
    }

    alertView = MMAlertView(title: "", detail: detail, items: items)

    alertView?.show()
  }
}
