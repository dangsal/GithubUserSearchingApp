//
//  UserDefatultStorage.swift
//  GithubUserSearch
//
//  Created by LeeSungHo on 9/30/23.
//

import Foundation

enum DataKeys: String, CaseIterable {
    case isLogin = "isLogin"
    case accessToken = "accessToken"
}

struct UserDefaultStorage {
    static var isLogin: Bool {
        return UserData<Bool>.getValue(forKey: .isLogin) ?? false
    }
    
    static var accessToken: String {
        return UserData<String>.getValue(forKey: .accessToken) ?? ""
    }
}

struct UserData<T> {
    static func getValue(forKey key: DataKeys) -> T? {
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? T {
            return data
        } else {
            return nil
        }
    }
    
    static func setValue(_ value: T, forKey key: DataKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func clearAll() {
        DataKeys.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
