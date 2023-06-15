//
//  GithubOAuthManager.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import Foundation
import UIKit

import Moya

final class GithubOAuthManager {
    static let shared = GithubOAuthManager()
    
    private let clientId = ""
    private let clientSecret = ""
    
    func requestAuthCode() {
        let scope = "user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=\(scope)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
}
