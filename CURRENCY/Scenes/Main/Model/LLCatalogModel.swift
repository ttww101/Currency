//
//  LJCatalogModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/22.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit
import Foundation

struct LLCatalogModel {
    
    var icon: UIImage?
    
    var description: String
    
    var controller: LLViewController
    
    init(catalog: LLCatalog) {
        self.icon = catalog.icon
        self.description = catalog.description
        self.controller = catalog.controller
    }
}

enum LLCatalog {
    
    case brand
    case breakfast
    case celebrity
    case drink
    case favorite
    case health
    case nearby
    case recommend
    case scan
    case use
    
    var icon: UIImage? {
        switch self {
        case .brand:
            return UIImage(named: "icon_brand")
        case .breakfast:
            return UIImage(named: "icon_breakfast")
        case .celebrity:
            return UIImage(named: "icon_celebrity")
        case .drink:
            return UIImage(named: "icon_drink")
        case .favorite:
            return UIImage(named: "icon_favorite")
        case .health:
            return UIImage(named: "icon_health")
        case .nearby:
            return UIImage(named: "icon_map")
        case .recommend:
            return UIImage(named: "icon_recommend")
        case .scan:
            return UIImage(named: "icon_scan")
        case .use:
            return UIImage(named: "icon_use")
        }
    }
    
    var description: String {
        switch self {
        case .brand:
            return "品牌"
        case .breakfast:
            return "早餐"
        case .celebrity:
            return "名廚"
        case .drink:
            return "飲品"
        case .favorite:
            return "最愛"
        case .health:
            return "養身"
        case .nearby:
            return "附近"
        case .recommend:
            return "推薦"
        case .scan:
            return "掃描"
        case .use:
            return "常用"
        }
    }
    
    var controller: LLViewController {
        switch self {
        case .brand:
            return LLBrandViewController()
        case .breakfast:
            return LLBreakfastViewController()
        case .celebrity:
            return CelebrityViewController()
        case .drink:
            return LLDrinkViewController()
        case .favorite:
            return LLFavoriteViewController()
        case .health:
            return LLHealthViewController()
        case .nearby:
            return LLNearbyViewController()
        case .recommend:
            return LLRecommendViewController()
        case .scan:
            return LLScanViewController()
        case .use:
            return LLUseViewController()
        }
    }
}



