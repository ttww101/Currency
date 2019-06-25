//
//  LLPrivacyViewModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/14.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Bond

import Foundation
import ReactiveKit

/// LLPrivacyViewModel
final class LLPrivacyViewModel {
    
    let aURL = Observable<String?>(nil)
    
    let isEnable = Observable<Bool>(false)
    
    init() {}
    
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        LLPrivacyClient().start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseJSON(data: data) {
                    self.aURL.value = object.data.first?.url
                    self.isEnable.value = true
                    completion(nil)
                } else {
                    completion(data.al.jsonErrorType(type: APIError.self))
                }
            } else {
                completion(APIError(code: nil,
                                    message: response.error?.localizedDescription))
            }
        }
    }
}

extension LLPrivacyViewModel: JSONDecodablePeorocol {

    typealias ResponseStruct = LLPrivacyModel?
    
    func parseJSON(data: Data) -> LLPrivacyModel? {
        return data.al.jsonType(type: LLPrivacyModel.self)
    }
}

