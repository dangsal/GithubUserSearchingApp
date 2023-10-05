//
//  GithubOAuthManager.swift
//  GithubUserSearch
//
//  Created by LeeSungHo on 9/30/23.
//

import UIKit

import Moya
// 싱글톤 패턴을 꼭 사용해야하나? usecase 로 바꾸는건 어때?
final class GithubOAuthManager {
    static let shared = GithubOAuthManager()
    
    private let provider: MoyaProvider<LoginEndPoint>
    private let clientId = Bundle.main.clientId
    private let clientSecret = Bundle.main.clientSecret
    private let scope = "user"
    
    private init() {
        self.provider = MoyaProvider<LoginEndPoint>()
    }
    
    func requestAuthCode() {
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(self.clientId)&scope=\(self.scope)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func requestAccessToken(with code: String, completion: @escaping(Result<String, Error>) -> Void) {
        let target = LoginEndPoint.fetchAccessToken(clientId: self.clientId,
                                                clientSecret: self.clientSecret,
                                                code: code)
        
        self.provider.request(target) {result in
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
