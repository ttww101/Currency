//
//  LLRegisterViewModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/28.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Bond

import Foundation
import ReactiveKit

/// LLRegisterViewModel
final class LLRegisterViewModel {
    
    let name = Observable<String?>(nil)
    
    let isFemale = Observable<Bool>(true)
    
    let birthday = Observable<String?>(nil)
    
    let email = Observable<String?>(nil)
    
    let password = Observable<String?>(nil)
    
    let passwordConfirm = Observable<String?>(nil)
    
    let phone = Observable<String?>(nil)
    
    init() {}
    
    /// Reqeust register api
    ///
    /// - Parameter completion:
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        
        guard let name     = name.value else { return }
        guard let birthday = birthday.value else { return }
        guard let email    = email.value else { return }
        guard let password = password.value else { return }
        guard let phone    = phone.value else { return }
        
        LLRegisterClient(name: name, sex: getGenderToRequestFormat(), email: email, phone: phone, birthday: birthday, password: password).start { (response) in
            if let data = response.value as? Data {
                /// Success parse User data and code is always equal to 0
                if let object = self.parseJSON(data: data), object.code == 0 {
                    completion(object)
                } else {
                    completion(data.al.jsonErrorType(type: APIError.self))
                }
            }
        }
    }
    
    /// Register form model
    ///
    /// - Returns: LLLoginFormModel
    func getNameFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "姓名", placeholder: "請輸入姓名", returnType: .done)
    }
    
    /// 0 Male, 1 Female
    ///
    /// - Returns: String
    private func getGenderToRequestFormat() -> String {
        return isFemale.value == true ? "1" : "0"
    }
    
    /// Password form model
    ///
    /// - Returns: LLLoginFormModel
    func getPasswordFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "密碼", placeholder: "請輸入密碼，至少6位", returnType: .next)
    }
    
    /// Password form model
    ///
    /// - Returns: LLLoginFormModel
    func getPasswordConfirmFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "確認密碼", placeholder: "請輸入確認密碼", returnType: .next)
    }
    
    /// Password form model
    ///
    /// - Returns: LLLoginFormModel
    func getPhoneFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "手機", placeholder: "請輸入手機號碼", returnType: .done)
    }
    
    /// Password form model
    ///
    /// - Returns: LLLoginFormModel
    func getEmailFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: nil, title: "信箱", placeholder: "請輸入信箱", returnType: .next)
    }
    
    /// Check `password` and `password confirm` is same or not
    ///
    /// - Returns: Bool
    func isPasswordConfrimSame() -> Bool {
        return (password.value == passwordConfirm.value) ? true : false
    }
    
    /// Check `password` is over six character
    ///
    /// - Returns: Bool
    func isPasswordOverSixCharacter() -> Bool {
        if let amount = password.value?.count, amount >= 6 {
            return true
        }
        return false
    }
    
    /// Check given sender is a right email format
    ///
    /// - Parameter sender: sender string
    /// - Returns: Bool
    func isRightEmailFormat(with sender: String?) -> Bool {
        if let email = sender, email.al.isValidEmail() {
            return true
        }
        return false
    }
    
    /// Check all fileds are filled or not
    ///
    /// - Returns: Bool
    func isDoneFillup() -> Bool {
        if self.name.value?.isEmpty ?? true ||
            self.birthday.value?.isEmpty ?? true ||
            self.email.value?.isEmpty ?? true ||
            self.password.value?.isEmpty ?? true ||
            self.passwordConfirm.value?.isEmpty ?? true ||
            self.phone.value?.isEmpty ?? true {
            return false
        }
        return true
    }
    
    /// Convert date format into request accept format
    ///
    /// - Parameter from: Date
    /// - Returns: String with "yyyy-MM-dd"
    func convert(from: Date) -> String {
        return from.al.stringType(format: "yyyy-MM-dd")
    }
}

extension LLRegisterViewModel {
    
    func parseJSON(data: Data) -> LLUserManager.Infos? {
        return data.al.jsonType(type: LLUserManager.Infos.self)
    }
}
