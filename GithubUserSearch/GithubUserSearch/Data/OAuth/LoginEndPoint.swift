//
//  LoginEndPoint.swift
//  GithubUserSearch
//
//  Created by LeeSungHo on 9/30/23.
//

import Foundation

import Moya

enum LoginEndPoint {
    case fetchAccessToken(clientId: String, clientSecret: String, code: String)
}

extension LoginEndPoint: TargetType {
    var baseURL: URL {
        switch self {
        case .fetchAccessToken: return URL(string: "https://github.com")!
        }
    }
    
    var path: String {
        switch self {
        case .fetchAccessToken: return "/login/oauth/access_token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAccessToken: return .post
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
        switch self {
        case .fetchAccessToken:
            return ["Accept": "application/json"]
        }
    }
}
