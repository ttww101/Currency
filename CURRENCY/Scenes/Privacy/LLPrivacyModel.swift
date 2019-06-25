//
//  LLPrivacyModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/14.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Foundation

/// LLPrivacyModel
final class LLPrivacyModel: Decodable {

    var code: Int
    var message: String?
    var datacnt: Int
    var data: [Privacy]
}

final class Privacy: Decodable {
    
    var infoid: String?
    var cCode: String?
    var appMenu: String?
    var subject: String?
    var openMode: String?
    var url: String?
}


