//
//  SelectSettingPresenter.swift
//  CURRENCY
//
//  Created by Stan Liu on 24/02/2018.
//  Copyright (c) 2018 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SelectSettingPresentationLogic {
  func presentFetchedTitle(response: SelectSetting.FetchTitle.Response)
  func presentFetchedOptions(response: SelectSetting.FetchSetting.Response)
  func presentChosenOption(response: SelectSetting.Select.Response)
}

class SelectSettingPresenter: SelectSettingPresentationLogic {
  weak var viewController: SelectSettingDisplayLogic?

  // MARK: Do something

  func presentFetchedTitle(response: SelectSetting.FetchTitle.Response) {
    let localizedTitle = LanguageWorker.shared.localizedString(key: response.titleLocalizedKey,
                                                               table: .listSettings)
    let viewModel = SelectSetting.FetchTitle.ViewModel(displayTitle: localizedTitle)
    viewController?.displayTitle(viewModel: viewModel)
  }

  func presentFetchedOptions(response: SelectSetting.FetchSetting.Response) {

    var table: LanguageTable = .listSettings
    if response.setting.type == .currency || response.setting.type == .source || response.setting.type == .unit {
      table = LanguageTable.listCurrency
    } else if response.setting.type == .language {
      table = LanguageTable.listLanguage
    }
    let values = response.setting.options.map {
      LanguageWorker.shared.localizedString(key: $0, table: table)
    }

    let viewModel = SelectSetting.FetchSetting.ViewModel(applyConfigurationHandler: response.setting.applyHandler,
                                                         optionKeys: response.setting.options,
                                                         optionValues: values,
                                                         currentOption: response.setting.currentOption)
    viewController?.displayFetchedOptions(viewModel: viewModel)
  }

  func presentChosenOption(response: SelectSetting.Select.Response) {
    let viewModel = SelectSetting.Select.ViewModel(chosen: response.chosen)
    viewController?.displayChosenOption(viewModel: viewModel)
  }
}
