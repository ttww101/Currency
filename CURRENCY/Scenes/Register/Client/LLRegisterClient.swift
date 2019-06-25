//
//  LLRegisterClient.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/5.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//


import Alamofire

/// LLRegisterClient
final class LLRegisterClient: Networkable {
    
    var parameters: [String : Any]? {
        var  _parameters = ["op": "RegisterNewMember",
                            "name": name,
                            "sex ": sex,
                            "email": email,
                            "mobile": phone,
                            "birthday": birthday,
                            "reg_type": "1",
                            "password": password] as [String : Any]
        _parameters += Configuration.API.authKey
        return _parameters
    }
    
    var method: HTTPMethod = .post
    
    var baseURL: String = Configuration.API.member
    
    var networkClient: NetworkClient = NetworkClient()
    
    var name: String
    
    var sex: String
    
    var email: String
    
    var phone: String
    
    var birthday: String
    
    var password: String
    
    init(name: String, sex: String, email: String, phone: String, birthday: String, password: String) {
        self.name = name
        self.sex = sex
        self.email = email
        self.phone = phone
        self.birthday = birthday
        self.password = password
    }
    
    func start(completion: @escaping Response) {
        self.networkClient.performRequest(self) { (response) in
            completion(response)
        }
    }
}

