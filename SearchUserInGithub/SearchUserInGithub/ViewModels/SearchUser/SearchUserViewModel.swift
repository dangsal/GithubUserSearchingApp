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

final class SearchUserViewModel {
    
    // MARK: - property
    
    @Published var users: [User] = []
    @Published var isEmpty: Bool = false
    var currentPage: Int = 1
    var isLoading: Bool = false
    var name: String = ""
    let errorMessage = PassthroughSubject<String, Never>()
    private var totalCount: Int = 0
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<GithubAPI>()
    
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
    
    private func handleError(_ error: Error) {
        let errorMessage = error.localizedDescription
        self.errorMessage.send(errorMessage)
    }
    
    private func handleResponse(_ response: SearchResult, page: Int) {
        if page == 1 {
            self.users = response.items
            self.totalCount = response.totalCount
        }
        else {
            self.users += response.items
        }
        self.isLoading = false
        self.isEmpty = response.items.isEmpty
    }
    
    // MARK: - network
    
    func requestUser(user: String, page: Int) {
        self.isLoading = true
        self.provider.requestPublisher(.searchUsers(query: user, page: page))
            .map(SearchResult.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleError(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.handleResponse(response, page: page)
            }
            .store(in: &self.cancellables)
    }
}
