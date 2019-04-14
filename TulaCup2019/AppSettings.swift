//
//  AppSettings.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 05/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import Foundation

// Yandex oath id for this application
//----------------------------------------
fileprivate let appid = "f32849370e824edd91e9a13c00139827"
//----------------------------------------

class AppSettings {
    
    static var oath: oathParams?
    
    static private let redirectUrl = "myapp://tula2019Cup/login"
    //static private let redirectUrl = "https://oauth.yandex.ru/verification_code"
    
    class func getRedirectUrl() -> String {
        return redirectUrl
    }
    
    class func getAppId() -> String {
        return appid
    }
    
    class func saveToDevice() {
        if self.oath != nil {
            let d = UserDefaults.standard
            
            d.set(oath!.accessToken, forKey: "token")
            d.set(oath!.tokenType, forKey: "type")
            d.set(oath!.expiresIn, forKey: "expires")
        }
    }
    
    class func loadFromDevice() {
        let d = UserDefaults.standard
        
        let token = d.string(forKey: "token")
        let type = d.string(forKey: "type")
        let expires = d.integer(forKey: "expires")
        
        self.oath = oathParams(token: token!, type: type!, expires: expires)
    }
}
