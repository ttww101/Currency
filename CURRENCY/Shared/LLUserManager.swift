//
//  User.swift
//  LaJoin
//
//  Created by stephen on 2019/4/22.
//  Copyright © 2019 lafresh. All rights reserved.
//

import Foundation

public final class LLUserManager {
    
    static let share = LLUserManager()
    
    // A Private initializer can only be called by this class itself.
    private init() {}
    
    public struct Infos: Codable {
        
        var vip_id: String?

        ///
        var name: String?

        ///
        var zip: String?

        ///
        var address: String?

        ///
        var telephone: String?

        ///
        var sex: String?

        ///
        var birthday: String?

        ///
        var email: String?

        ///
        var mobile: String?

        ///
        var last_point: String?

        ///
        var last_amt: String?

        ///
        var last_icpoint: String?

        ///
        var vip_center: String?

        ///
        var center_area: String?

        ///
        var center_mobile: String?

        ///
        var vip_level: String?

        ///
        var vip_level_name: String?

        ///
        var card: String?

        ///
        var end_date: String?

        ///
        var id_card: String?

        ///
        var iccardno: String?

        ///
        var searchtyp: String?

        ///
        var education_id: String?

        ///
        var marriage: String?

        ///
        var fax: String?

        ///
        var occupation: String?

        ///
        var company: String?

        ///
        var linkman: String?

        ///
        var contact: String?

        ///
        var work_title: String?

        ///
        var company_zip: String?

        ///
        var company_addr: String?

        ///
        var pubtype_def: String?

        ///
        var pubid_def: String?

        ///
        var pubtype: String?

        ///
        var pubid: String?

        ///
        var pubemail: String?

        ///
        var publogid: String?

        ///
        var publogpw: String?

        ///
        var black: String?

        ///
        var bind_flag: Int?

        ///
        var memberToken: String?

        ///
        var acckey: String?

        ///
        var code: Int
        
        ///
//        var bind_list:
        
        ///
        var message: String
    }
    
    public var infos: Infos?
    
    /// Check User is login or not
    ///
    /// - Returns: Bool
    public func isLogin() -> Bool {
        return infos == nil ? false : true
    }
    
    /// FIXME: Maybe i can use keychain ???
    
    /// Logout user
    public func logout() {
        UserDefaults.standard.removeObject(forKey: "Configuration.Key.user")
        self.infos = nil
    }
 
    /// When user login or success, set to LLUserManager via this function
    ///
    /// - Parameter value: LLUserManager.Infos
    public func login(value: LLUserManager.Infos) {
        self.infos = value
        if let encoder = try? PropertyListEncoder().encode(value) {
            UserDefaults.standard.set(encoder, forKey: "Configuration.Key.user")
        }
    }
    
    public func retrive() {
        if let storedObject = UserDefaults.standard.object(forKey: "Configuration.Key.user") as? Data {
            self.infos = try? PropertyListDecoder().decode(LLUserManager.Infos.self, from: storedObject)
        }
    }
}

public enum NeverC {}

