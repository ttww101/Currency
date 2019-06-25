//
//  LLVerificationClient.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/12.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//


import Alamofire

/// LLVerificationClient
final class LLVerificationClient: Networkable {

    var parameters: [String : Any]? {
        var  _parameters = ["op": "auth",
                            "sId": self.phone,
                            "auth_code": self.code] as [String : Any]
        _parameters += Configuration.API.authKey
        return _parameters
    }
    
    var method: HTTPMethod = .post
    
    var baseURL: String = Configuration.API.member
    
    var networkClient: NetworkClient = NetworkClient()
    
    private var phone: String
    
    private var code: String
    
    init(phone: String, code: String) {
        self.phone = phone
        self.code = code
    }
    
    func start(completion: @escaping Response) {
        self.networkClient.performRequest(self) { (response) in
            completion(response)
        }
    }
}
