//
//  LLMemberViewModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/2/2.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Bond
import Foundation
import ReactiveKit

final class LLMemberViewModel {

    private let password = Observable<String?>("")
    
    private let phone = Observable<String?>("")
    
    init() {}
    
    func getViewData() -> [LLMemberFormModel] {
        
        // 性別 0:男; 1:女
        let gender = LLUserManager.share.infos?.sex == "1" ? "女" : "男"
        
        return [
            LLMemberFormModel(imageName: nil,
                              title: "姓名",
                              text: LLUserManager.share.infos?.name),
            LLMemberFormModel(imageName: nil,
                              title: "性別",
                              text: gender),
            LLMemberFormModel(imageName: nil,
                              title: "生日",
                              text: LLUserManager.share.infos?.birthday),
            LLMemberFormModel(imageName: nil,
                              title: "手機",
                              text: LLUserManager.share.infos?.mobile),
            LLMemberFormModel(imageName: "icon_calendar",
                              title: "信箱",
                              text: LLUserManager.share.infos?.email),
            LLMemberFormModel(imageName: "icon_calendar",
                              title: "密碼",
                              text: "**********")
        ]
    }
    
}


