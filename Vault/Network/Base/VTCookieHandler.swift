//
//  VTCookieHandler.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation

class VTCookieHandler {
    
    static let shared: VTCookieHandler = VTCookieHandler()
    
    let defaults = UserDefaults.standard
    let cookieStorage = HTTPCookieStorage.shared
    
    func getCookie() -> [HTTPCookie]? {
        let cookies = cookieStorage.cookies
        return cookies
    }
    
    func backupCookies() -> Void {
        if let cookies = HTTPCookieStorage.shared.cookies,
           let cookiesData = try? NSKeyedArchiver.archivedData(withRootObject: cookies, requiringSecureCoding: false){ // 序列化数据
            let defaults = UserDefaults.standard
            defaults.set(cookiesData, forKey: "hu.vault.com")
        }
    }
    
    func restoreCookies() {
        if let data = UserDefaults.standard.object(forKey: "hu.vault.com") as? Data,
           let cookies = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [HTTPCookie]{
            for cookie in cookies {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }
}
