//
//  ViewModel.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Combine
import Foundation

import Moya

final class SearchUserViewModel {
    
    // MARK: - property
    
    @Published var users: [User] = []
    @Published var isEmpty: Bool = false
    var currentPage: Int = 1
    var isLoading: Bool = false
    var name: String = ""
    private var totalCount: Int = 0
    
    // MARK: - func
    
    func numberOfRowInSection(_ section: Int) -> Int {
        return self.users.count
    }
    
    func userAtIndex(_ index: Int) -> UserViewModel {
        let user = self.users[index]
        
        return UserViewModel(user)
    }
    
    func userUrlAtIndex(_ index: Int) -> URL? {
        guard index < self.users.count else { return nil }
        let user = self.users[index]
        
        return URL(string: user.url)
    }
    
    func requestNextPage() {
        if self.currentPage <= self.totalCount / 30 {
            self.increaseCurrentPage()
            self.requestUser(user: self.name, page: self.currentPage)
        }
        return
    }
    
    func resetCurrentPage() {
        self.currentPage = 1
    }
    
    func increaseCurrentPage() {
        self.currentPage += 1
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    // MARK: - network
    
    func requestUser(user: String, page: Int) {
        let provider = MoyaProvider<GithubAPI>()
        self.isLoading = true
        provider.request(.searchUsers(query: user, page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(SearchResult.self)
                    if page == 1 {
                        self.users = response.items
                        self.totalCount = response.totalCount
                        self.isLoading = false
                    }
                    else {
                        self.users += response.items
                        self.isLoading = false
                    }
                    self.isEmpty = response.items.isEmpty
                } catch {
                    print("json mapping error")
                }
            case .failure(let error):
                print("network error", error)
            }
        }
    }
}
