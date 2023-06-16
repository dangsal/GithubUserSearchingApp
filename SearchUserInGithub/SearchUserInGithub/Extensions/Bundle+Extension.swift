//
//  Bundle+Extension.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/16.
//

import Foundation

extension Bundle {
    
    var clientId: String {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
        }
        guard let value = plistDict.object(forKey: "clientId") as? String else {
            fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
        }
        return value
    }
    var clientSecret: String {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
        }
        guard let value = plistDict.object(forKey: "clientSecret") as? String else {
            fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
        }
        return value
    }
}
