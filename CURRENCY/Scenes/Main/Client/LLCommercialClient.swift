//
//  LLMainCommercialClient.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/6.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Aletheia
import Alamofire

/// LLMainCommercialClient
final class LLCommercialClient: Networkable {

    var parameters: [String : Any]? {
        return ["op": "get_commercial_district"]
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
