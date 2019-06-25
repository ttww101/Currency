//
//  LLForgetPasswordClient.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/28.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//


import Alamofire
import Foundation

final class LLForgetPasswordClient: Networkable {
    
    var parameters: [String : Any]? {
        var  _parameters = ["op":      "sms_auth",
                            "mobile":   self.mobile] as [String : Any]
        _parameters += Configuration.API.authKey
        return _parameters
    }
    
    var method: HTTPMethod = .post
    
        var baseURL: String = Configuration.API.member
    
    var networkClient: NetworkClient = NetworkClient()
    
    private var mobile: String
    
    init(mobile: String) {
        self.mobile = mobile
    }
    
    func start(completion: @escaping Response) {
        self.networkClient.performRequest(self) { (response) in
           completion(response)
        }
    }
}
