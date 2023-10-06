//
//  UserInfoDTO.swift
//  GithubUserSearch
//
//  Created by 이성호 on 10/6/23.
//

import Foundation

struct UserInfoDTO: Decodable {
    let login: String?
    let avatarURL: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case url = "html_url"
        case avatarURL = "avatar_url"
    }
}

extension UserInfoDTO {
    func toUserInfo() -> UserInfo {
        return UserInfo(login: self.login ?? "", avatarURL: self.avatarURL ?? "", url: self.url ?? "")
    }
}
