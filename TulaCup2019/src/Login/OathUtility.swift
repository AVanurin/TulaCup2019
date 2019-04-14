//
//  OathUtility.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 05/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import Foundation


let yandexOathUrl = "https://oauth.yandex.ru/authorize"

public func makeOathUrl() -> String {
    //let urlString = "\(yandexOathUrl)?response_type=code&client_id=\(AppSettings.getAppId())&redirect_uri=\(AppSettings.getRedirectUrl())"

    let urlString = "\(yandexOathUrl)?response_type=token&client_id=\(AppSettings.getAppId())"
    
    return urlString
}


struct oathParams {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    
    init?(from: String) {
        let trimmedString = from.replacingOccurrences(of: "myapp://tula2019Cup/login#", with: "")
        let params =  Array(trimmedString.split(separator: "&"))
        accessToken =  String((params[0].split(separator: "=")).last!)
        tokenType =  String((params[1].split(separator: "=")).last!)
        expiresIn =  Int(String((params[2].split(separator: "=")).last!))!
    }
    
    init(token a: String, type t: String, expires e: Int) {
        self.accessToken = a
        self.tokenType = t
        self.expiresIn = e
    }
}
