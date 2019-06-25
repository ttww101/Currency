//
//  LLVerificationViewModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/12.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Bond

import Foundation
import ReactiveKit

/// LLVerificationViewModel
final class LLVerificationViewModel {

    let code = Observable<String?>("")
    
    let resend = Observable<String?>("")
   
    private var totalTime = 60
    
    private lazy var timer: Timer = {
        return Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LLVerificationViewModel.counting), userInfo: nil, repeats: true)
    }()
    
    init() { }
    
    func requestAPI(mobile: String, completion: @escaping (_ any: Any?) -> ()) {
        
        guard let code = self.code.value else {
            completion(nil)
            return
        }
        
        LLVerificationClient(phone: mobile, code: code).start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseJSON(data: data) {
                    completion(object)
                } else {
                    completion(data.al.jsonErrorType(type: APIError.self))
                }
            } else {
                completion(APIError(code: nil,
                                    message: response.error?.localizedDescription))
            }
        }
    }
    
    func isCodeEmpty() -> Bool {
        return code.value?.isEmpty ?? true
    }
    
    func setupTimer() {
        self.timer.fire()
    }
    
    @objc private func counting() {
        self.totalTime -= 1
        if self.totalTime == 0 {
            self.timer.invalidate()
            self.totalTime = 60
        }
        self.resend.value = "重新發送認證簡訊(\(self.totalTime))"
    }
}

extension LLVerificationViewModel: JSONDecodablePeorocol {

    typealias ResponseStruct = LLVerificationModel?
    
    func parseJSON(data: Data) -> LLVerificationModel? {
        return data.al.jsonType(type: LLVerificationModel.self)
    }
}

