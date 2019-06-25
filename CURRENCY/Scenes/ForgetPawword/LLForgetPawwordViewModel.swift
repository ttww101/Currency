//
//  LLForgetPasswordViewModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/28.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//
import Bond

import Foundation
import ReactiveKit

final class LLForgetPasswordViewModel {
    
    #if DEBUG
    let phone = Observable<String?>("0982885485")
    #else
    let phone = Observable<String?>(nil)
    #endif
    
    init() { }
    
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        LLForgetPasswordClient(mobile: phone.value!).start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseJSON(data: data) {
                    completion(object)
                } else {
                    completion(data.al.jsonErrorType(type: APIError.self))
                }
            } else {
                completion(APIError(code: nil, message: response.error?.localizedDescription))
            }
        }
    }
    
    func isPasswordEmpty() -> Bool {
        return phone.value?.isEmpty ?? true
    }
}

extension LLForgetPasswordViewModel: JSONDecodablePeorocol {
    
    typealias ResponseStruct = APIError?
    
    func parseJSON(data: Data) -> APIError? {
        return data.al.jsonType(type: APIError.self)
    }
}

