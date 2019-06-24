//
//  LLBannerModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/14.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Foundation

struct LLBannerModel: Decodable {
    
    var code: Int
    var message: String?
    
    var datacnt: Int
    
    var imgpath: String?
    
    var data: [BannerDetail]
}

struct BannerDetail: Decodable {
    
    var bannerid: String?
    var subject: String?
    var url: String?
    var imgfile1: String?
}
