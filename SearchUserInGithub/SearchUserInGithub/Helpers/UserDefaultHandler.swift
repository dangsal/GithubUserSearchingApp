//
//  UserDefaultHandler.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Foundation

enum DataKeys: String, CaseIterable {
    case isLogin = "isLogin"
}

struct UserDefaultStorage {
    static var isLogin: Bool {
        return UserData<Bool>.getValue(forKey: .isLogin) ?? false
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
            print(key.rawValue)
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
