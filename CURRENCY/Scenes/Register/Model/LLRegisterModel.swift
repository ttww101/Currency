//
//  LLRegisterModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/31.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit

final class LLRegisterModel: Decodable {
    
    var name: String?

    var sex: String?
    
    var birthday: String?
    
    var email: String?
    
    var mobile: String?
    
    var code: Int = 0
    
    var message: String?
}

