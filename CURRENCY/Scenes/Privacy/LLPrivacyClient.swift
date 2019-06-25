//
//  LLPrivacyClient.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/14.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//


import Alamofire

/// LLPrivacyClient
final class LLPrivacyClient: Networkable {

    var parameters: [String : Any]? {
        var  _parameters = ["op": "get_page_list"] as [String : Any]
        _parameters += Configuration.API.authKey
        return _parameters
    }
    
    var method: HTTPMethod = .post
    
    var baseURL: String = Configuration.API.basic
    
    var networkClient: NetworkClient = NetworkClient()
    
    init() {}
    
    func start(completion: @escaping Response) {
        self.networkClient.performRequest(self) { (response) in
            completion(response)
        }
    }
}
