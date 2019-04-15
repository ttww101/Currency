//
//  EditConvertCurrencyModels.swift
//  CURRENCY
//
//  Created by Stan Liu on 09/02/2018.
//  Copyright (c) 2018 Stan Liu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum EditConvertCurrency {
  // MARK: Use cases

  enum Favorites {
    struct Request {
    }
    struct Response {
      struct FavoriteCurrency {
        var name: String
        var isFavored: Bool
      }
      var currencies: [FavoriteCurrency]
    }
    struct ViewModel {
      struct DisplayCurrency {
        var name: String
        var isFavored: Bool
      }
      var displayCurrencies: [DisplayCurrency]
    }
  }

  enum Update {
    struct Request {
      var indexPath: IndexPath
      var name: String
    }
    struct Response {
      var indexPath: IndexPath
      var currencies: [Favorites.Response.FavoriteCurrency]
    }
    struct ViewModel {
      var indexPath: IndexPath
      var displayCurrencies: [Favorites.ViewModel.DisplayCurrency]
    }
  }
}
