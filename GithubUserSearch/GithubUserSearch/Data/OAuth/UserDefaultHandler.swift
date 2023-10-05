//
//  UserDefaultHandler.swift
//  GithubUserSearch
//
//  Created by LeeSungHo on 9/30/23.
//

import Foundation

struct UserDefaultHandler {
    
    static func clearAllData() {
        UserData<Any>.clearAll()
    }
    
    static func setIsLogin(isLogin: Bool) {
        UserData.setValue(isLogin, forKey: .isLogin)
    }
    
    static func setAccessToken(accessToken: String) {
        UserData.setValue(accessToken, forKey: .accessToken)
    }
}

