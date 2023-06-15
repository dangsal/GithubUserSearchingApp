//
//  UserViewModel.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Foundation

struct UserViewModel {
    
    private var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    var userName: String? {
        return self.user.login
    }
    
    var userUrl: String? {
        return self.user.url
    }
    
    var userImage: String? {
        return self.user.avatarURL
    }
}
