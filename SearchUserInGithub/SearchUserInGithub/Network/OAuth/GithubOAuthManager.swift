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
    
    private let provider: MoyaProvider<GithubAPI>
    private let clientId = Bundle.main.clientId
    private let clientSecret = Bundle.main.clientSecret
    private let scope = "user"
    
    private init() {
        self.provider = MoyaProvider<GithubAPI>()
    }
    
    func requestAuthCode() {
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=\(scope)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func requestAccessToken(with code: String, completion: @escaping(Result<String, Error>) -> Void) {
        let target = GithubAPI.fetchAccessToken(clientId: clientId, clientSecret: clientSecret, code: code)
        
        provider.request(target) {result in
            switch result {
            case .success(let response):
                do {
                    let accessToken = try response.mapString(atKeyPath: "access_token")
                    UserDefaultHandler.setAccessToken(accessToken: accessToken)
                    completion(.success(accessToken))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
