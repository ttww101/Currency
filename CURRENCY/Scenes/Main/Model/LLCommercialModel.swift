//
//  LLCommercialDistrict.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/6.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Foundation

struct LLCommercialModel: Decodable {
    
    var code: Int
    
    var message: String
    
    var datacnt: Int

    var data: [Commercials]
}

struct Commercials: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "commercialDistrictId"
        case name
        case tel
        case fax
        case email
        case contact
        case jobtitle
        case htmlbody
    }

    var id: String
    var name: String?
    var tel: String?
    var fax: String?
    var email: String?
    var contact: String?
    var jobtitle: String?
    var htmlbody: String?
}

