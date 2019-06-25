//
//  LLLoginViewModel.swift
//  LaJoin
//
//  Created by stephen on 2019/4/23.
//  Copyright © 2019 lafresh. All rights reserved.
//

import Bond
import Foundation
import ReactiveKit

final class LLLoginViewModel {
    
    #if DEBUG
    let account = Observable<String?>("0982885485")
    
    let password = Observable<String?>("123456")
    #else
    let account = Observable<String?>(nil)
    
    let password = Observable<String?>(nil)
    #endif
    
    init() {}
    
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        /// FIXME: 免去 ！
        LLLoginClient(account: account.value!, password: password.value!).start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseJSON(data: data) {
                       completion(object)
                } else {
//                    completion(data.al.jsonErrorType(type: APIError.self))
                }
            } else {
//                completion(APIError(code: nil, message: response.error?.localizedDescription))
            }
        }
    }
    
    func isEmpty() -> Bool {
//        if self.LLLoginViewModelisEmpty ?? true ||
//            self.password.value?.isEmpty ?? true {
//            return true
//        }
        return false
    }
}

extension LLLoginViewModel {
    
    typealias ResponseStruct = LLUserManager.Infos?
    
    func parseJSON(data: Data) -> LLUserManager.Infos? {
        return data.al.jsonType(type: LLUserManager.Infos.self)
    }
}

