//
//  LLForgetPasswordModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/29.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Foundation

struct LLForgetPasswordModel: Codable {
    
    var code: String
    var auth_code: String
    var message: String
    var mobile: String
}
