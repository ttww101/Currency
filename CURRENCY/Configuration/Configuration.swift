//
//  Configuration.swift
//  CURRENCY
//
//  Created by Stan Liu on 14/11/2017.
//  Copyright © 2017 Stan Liu. All rights reserved.
//

import Hue

/// App Configurations
enum Configuration {

  // MARK: Storage Path

  enum Storage {
    static let sourceDirectoryPath = "CurrencySource/"
  }

  // MARK: Theme

  enum Theme {
    static let blue = UIColor(hex: "292787")
    static let mediumLightBlue = UIColor(hex: "6967ab")
    static let lightBlue = UIColor(hex: "C0C0DA")
    static let darkBlue = UIColor(hex: "27297E")
    static let red = UIColor(hex: "ED1946")
    static let green = UIColor(hex: "10EDC5")
    static let darkGray = UIColor(hex: "4A4A4A")
    static let mediumGray = UIColor(hex: "A4A4A4")
    static let lightGray = UIColor(hex: "ffcf8e")
    static let white = UIColor(hex: "FFFFFF")
    static let yellow = UIColor(hex: "FFE463")
    static let lightYellow = UIColor(hex: "FFF7AF")
    static let black = UIColor(hex: "000000")
    static let headerDefaultColor = UIColor(hex: "F7F7F7")
    static let pink = UIColor(hex: "E86996")
    static let lightPink = UIColor(hex: "F5C3D5")
    
    
    static let textColor = UIColor(hex: "f08300")
  }

  // MARK: Font

  static let systemFont = UIFont.systemFont(ofSize: 14)
  enum Font {
    static let numericFont = R.font.hurmeGeometricSans1Regular(size: 14) ?? systemFont
    static let letterFont = R.font.truenoLt(size: 14) ?? systemFont
    static let ballonFont = R.font.hurmeGeometricSans1Regular(size: 14) ?? systemFont

    static let normalTitleFont = R.font.truenoRg(size: 17) ?? systemFont
    static let largeTitleFont = R.font.truenoRg(size: 28) ?? systemFont
    static let navigationItemFont = R.font.truenoRg(size: 16) ?? systemFont
  }

  // MARK: Date Format

  struct Date {
    var mdFormatter: DateFormatter {
      let _dateFormatter = DateFormatter()
      _dateFormatter.dateFormat = "MM/dd"
      return _dateFormatter
    }

    var dateFormatter: DateFormatter {
      let _dateFormatter = DateFormatter()
      _dateFormatter.dateFormat = "YYYY/MM/dd"
      return _dateFormatter
    }

    var timeFormatter: DateFormatter {
      let _dateFormatter = DateFormatter()
      _dateFormatter.dateFormat = "YYYY/MM/dd HH:mm" // "YYYY/MM/dd HH:mm:ss"
      return _dateFormatter
    }

    var preciseTimeFormatter: DateFormatter {
      let _dateFormatter = DateFormatter()
      _dateFormatter.dateFormat = "YYYY/MM/dd HH:mm:ss.SSSS"
      return _dateFormatter
    }
  }

  struct Number {
    func formatter(position: Int) -> NumberFormatter {
      let _formatter = NumberFormatter()
      _formatter.minimumFractionDigits = 0
      _formatter.maximumFractionDigits = position
      _formatter.numberStyle = .decimal
      return _formatter
    }
  }

  enum AppStore {
    static let appleID = "1351658325"
  }

  enum Ads {

    // Conditions for present ads
    enum AdsCondition {
      static let shouldPresentAtFirst: Bool = false
      static let fullPagePresentPeriod: Double = 180.0 // jump out ads after 1000 * seconds and half minutes
      static let calculatedCount: Int = 35 // tap number and del btn more than %d times will trigger ads
    }

    enum MoPub {
      static let AdsOfCell = "8775e1315ab247d584e1d5375aeb4f8c"
      static let fullPage = "fdfd87fb781f4793bc940aad7d2ceefa"
    }
    enum Facebook {
      // 資產
      // 版位
      enum NativeAds {
        static let autoGeneric = "467838126967740_468328316918721"
      }
      enum IntertitialAds {
        static let fullPage = "467838126967740_468315366920016"
      }
    }
    enum AdColony {
      static let appId = "app74044a667dd74543a2"
      static let fullPage = "vz439b6f52ad164cf6a3"
    }
  }
}

