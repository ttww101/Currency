//
//  KKConfiguration.swift
//  ExchangeHelper
//
//  Created by stephen on 2019/04/26.
//  Copyright © 2017 Meiliang Wen. All rights reserved.
//

import Hue
import Foundation

/// App KKConfigurations
enum KKConfiguration {

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


/// <# important #> This variable swtich bwtween <#Prod#> and <#Dev#> model for entire app
let isDebug: Bool = false

/// All configurations for this app
enum Configuration {
    

    
    // ******************************************
    //
    // MARK: - Theme, Entire app color theme
    //
    // ******************************************
    
    enum Theme {
        // FFDA00
        static let main = UIColor(hex: "f08300")
        
        static let navigationTitleColor = UIColor.black
        
        static let subtitle = UIColor.gray
    }
    
    // ******************************************
    //
    // MARK: - Font
    //
    // ******************************************
    
    enum Font {
        static let normal = UIFont.systemFont(ofSize: 17.0)
        
        static let system = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        
        static let support = UIFont.systemFont(ofSize: 14.0)
    }
    
    // ******************************************
    //
    // MARK: - UI & Animation
    //
    // ******************************************
    
    enum UI {
        static let cornerRadius: CGFloat = 6.0
        
        static let toastDuration: Double = 1.0
    }
}

extension Configuration {
    
    // ******************************************
    //
    // MARK: - API Request URL
    //
    // ******************************************
    
    enum API {
        
        static let domain = isDebug
            ? "http://testiis.la-join.com.tw:9443/lajoin/app/"
            : "https://www.lafresh.com.tw/lajoin/app/"
        
        /// Domain + endpoint
        static let member           = Configuration.API.domain
            + "webservice/member/index.php"
        static let basic            = Configuration.API.domain
            + "webservice/basic/index.php"



        
        /// Company Auth key
        static var authKey = ["authkey": "vqgbturz6eu9e9lmkazz8d20tvkqig0a"]
    }
}


extension Configuration {
    
    // ******************************************
    //
    // MARK: - Key
    //
    // ******************************************
    
    enum Key {
        static let user = "Configuration.Key.user"

        
        
    }
}


extension Configuration {
    
    // ******************************************
    //
    // MARK: - APP Context Text
    //
    // ******************************************
    
    enum Context {
        
        static let checkout = "結帳"
        static let cart = "購物車"
        static let add2Cart = "加入購物車"
        static let leave = "是否確定離開此商店，離開將會清空您的購物車"
        static let back2Main = "回首頁"
        static let cancel = "取消"
        static let title = "標題"
        static let next = "下一步"
        static let confirm = "確定"
        static let orderOnce = "一次僅可從一家餐廳訂購餐點"
        static let verificationCode = "傳送驗證碼"
        static let transactionSuccess = "交易成功"
        
        static let noData = "沒有資料"
        static let noProductData = "沒有商品資料"
        
        static let wrongEmailFormat = "請輸入正確的 email 格式"
        
        static let passwordNotSame = "兩次密碼輸入不同"
        static let passwordWrongLenght = "請輸入 6 位字以上"
        
        static let wayDeliveries = "取餐方式"
        static let wayPayments = "付款方式"
        
        static let checkOrderStatus = "交易成功\n您可以從購買紀錄\n查詢記單狀態"
        
        static let enterShop = "請輸入商店名稱"
        static let enterPhone = "請輸入手機號碼"
        static let enterCode = "請輸入驗證碼"
        static let enterComplete = "請輸入完整格式"
        
        static let comingSoon = "即將開放，敬請期待"
        
        
        
        static let selectTitle = "請選擇取餐日期及時間"
        static let selectSubtitle = "為避免您選購到無法供餐之商品\n請先進行取餐時間設定"
        static let selectDate = "取餐日期"
        static let selectTime = "取餐時間"
        
        static let installLine = "請安裝 Line App 來完成付款"
    }
}



