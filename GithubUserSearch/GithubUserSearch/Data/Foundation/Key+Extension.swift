//
//  Key+Extension.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/29.
//

import Foundation

extension Bundle {
    var clientId: String {
        guard let file = self.path(forResource: "Key", ofType: "plist") else { return "Key 파일이 없습니다." }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["clientId"] as? String else { fatalError("clientId를 입력해주세요.") }
        return key
    }
    
    var clientSecret: String {
        guard let file = self.path(forResource: "Key", ofType: "plist") else { return "Key 파일이 없습니다." }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["clientSecret"] as? String else { fatalError("clientSecret를 입력해주세요.") }
        return key
    }
}
