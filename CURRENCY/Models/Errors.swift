//
//  NetworkError.swift
//  ExchangeHelper
//
//  Created by joe on 2019/04/27.
//  Copyright © 2018 Meiliang Wen. All rights reserved.
//

import Rswift
import Foundation

enum Base {
  enum HandleError {
    struct Request {
      var error: Error
    }
    struct Response {
      var error: Error
    }
    struct ViewModel {
      var error: Error
    }
  }
}

enum NetworkError: Error {
  case server
  case noInternet

  var localizedDescription: String {
    switch self {
    case .server:
      return LanguageWorker.shared.localizedString(key: R.string.error.fetch_remote_error.key,
                                                   table: .appError)
    case .noInternet:
      return LanguageWorker.shared.localizedString(key: R.string.error.disconnect_error.key,
                                                   table: .appError)
    }
  }
}

enum LoadDataError: Error {
  case empty
  var localizedDescription: String {
    return LanguageWorker.shared.localizedString(key:
        R.string.error.fetch_local_error.key,
                                                 table: .appError)
  }
}

enum FetchDataError: Error {
  case remote
  case local
  var localizedDescription: String {
    switch self {
    case .remote:
      return NetworkError.server.localizedDescription
    case .local:
      return LoadDataError.empty.localizedDescription
    }
  }
}

enum APIAnalyzeError: Error {
  case google
}

enum UserSettingError: Error {
  case language
  case source
  case currency
  case decimal
  case baseCurrency
  case favoriteCurrencies

  var localizedDescription: String {
    switch self {
    case .language:
      return "language"
    case .source:
      return "source"
    case .currency:
      return "currency"
    case .decimal:
      return "decimal"
    case .baseCurrency:
      return "baseCurrency"
    case .favoriteCurrencies:
      return "favoriteCurrencies"
    }
  }
}
