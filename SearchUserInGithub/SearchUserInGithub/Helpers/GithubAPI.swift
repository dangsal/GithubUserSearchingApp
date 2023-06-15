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
    case searchUsers(query: String)
}

extension GithubAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .fetchAccessToken:
            return URL(string: "https://github.com")!
        case .searchUsers:
            return URL(string: "https://api.github.com")!
        }
        
    }
    
    var path: String {
        switch self {
        case .fetchAccessToken:
            return "/login/oauth/access_token"
        case .searchUsers:
            return "/search/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAccessToken:
            return .post
        case .searchUsers:
            return .get
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
        case .searchUsers(let query):
            let parameters: [String: Any] = [
                "q": query
                ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchAccessToken:
            return ["Accept": "application/json"]
        case .searchUsers:
            return ["Accept": "application/vnd.github+json",
                    "Authorization": "Bearer \(UserDefaultStorage.accessToken)"
                    ]
        }
    }
}
