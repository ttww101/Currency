//
//  APIError.swift
//  LaJoin
//
//  Created by stephen on 2019/4/29.
//  Copyright © 2019 lafresh. All rights reserved.
//

import Foundation

struct APIError: Decodable {
    var code: Double?
    var message: String?
}
