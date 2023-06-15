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
    //FIXME: 값 숨길것
    private let clientId = "9599314b3ce229888c5f"
    private let clientSecret = "81ee9a3f84c3b3853ef419802a9f7274c2db33a6"
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
