//
//  ViewModel.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Combine
import Foundation

import CombineMoya
import Moya

final class ViewModel {
    
    @Published var users: [User] = []
    @Published var isEmpty: Bool = false
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowInSection(_ section: Int) -> Int {
        return self.users.count
    }
    
    func userAtIndex(_ index: Int) -> UserViewModel {
        let user = self.users[index]
        
        return UserViewModel(user)
    }
    
    func userUrlAtIndex(_ index: Int) -> URL? {
        guard index < users.count else { return nil }
        let user = self.users[index]
        
        return URL(string: user.url)
    }
    
    func requestUser(user: String) {
        let provider = MoyaProvider<GithubAPI>()
        
        provider.request(.searchUsers(query: user)) { result in
            switch result {
            case .success(let response):
                do {
                    let users = try response.map(SearchResult.self)
                    self.users = users.items
                    self.isEmpty = users.items.isEmpty
                } catch {
                    print("json mapping error")
                }
            case .failure(let error):
                print("network error", error)
            }
        }
    }
    
}
