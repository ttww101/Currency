//
//  LLShopModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/7.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Foundation

struct LLShopModel: Decodable {
    
    var code: Int
    
    var message: String
    
    var datacnt: Int
    
    /// Commercial District Name
    var name: String
    
    var data: [LLShop]
    
    private enum CodingKeys: String, CodingKey {
        case name = "commercialDistrictName"
        case code
        case message
        case datacnt
        case data
    }
}

struct LLShop: Decodable {
    
    var companyId: String?
    var shopId: String
    var shopName: String
//    var shopKind: String?
    var tel: String?
//    var fax: String?
//    var zip: String?
//    var worktime: String?
    var address: String?
//    var longitude: String?
//    var latitude: String?
//    var povHeading: String?
//    var povPitch: String?
//    var povZoom: String?
//    var appmeal: String?
    var htmlbody: String?
    var imgfile1: String?
//    var score: String?
    var authkey: String
}
