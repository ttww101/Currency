//
//  LLGetShopClient.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/7.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Aletheia
import Alamofire

/// LLGetShopClient
final class LLGetShopClient: Networkable {

    var parameters: [String : Any]? {
        return ["op": "get_shop",
                "commercial_district_id": self.commercialID] as [String : Any]
    }
    
    var method: HTTPMethod = .post
    
    var baseURL: String = Configuration.API.basic
    
    var networkClient: NetworkClient = NetworkClient()
    
    var commercialID: String
    
    init(commercialID: String) {
        self.commercialID = commercialID
    }
    
    func start(completion: @escaping Response) {
        self.networkClient.performRequest(self) { (response) in
            completion(response)
        }
    }
}
