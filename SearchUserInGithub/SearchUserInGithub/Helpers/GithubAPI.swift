//
//  GithubAPI.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Foundation

import Moya

enum GithubAPI {
    case fetchAccessToken(clientId: String, clientSecret: String, code: String)
}

extension GithubAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://github.com")!
    }
    
    var path: String {
        switch self {
        case .fetchAccessToken:
            return "/login/oauth/access_token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAccessToken:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAccessToken(let clientId, let clientSecret, let code):
            let parameters: [String: Any] = [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code
                ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
}
