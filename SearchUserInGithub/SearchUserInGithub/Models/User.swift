//
//  User.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatarURL: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case login, url
        case avatarURL = "avatar_url"
    }
}
