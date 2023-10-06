//
//  LoginViewModel.swift
//  GithubUserSearch
//
//  Created by LeeSungHo on 9/30/23.
//

import Combine
import Foundation

import RxSwift
import RxRelay

final class LoginViewModel {
    
    struct Input {
        let loginButtonDidTapEvent: AnyPublisher<Void, Never>
    }
    
    struct Output {
        
    }
    
    // MARK: - property
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - init
    init() {
        
    }
    
    // MARK: - func
    
    func transform(from input: Input) -> Output {
        input.loginButtonDidTapEvent
            .sink { [weak self] _ in
                self?.fetchOAuthCode()
            }
            .store(in: &self.cancellable)
        return Output()
    }
    
    private func fetchOAuthCode() {
        let apiManager = GithubOAuthManager.shared
        apiManager.requestAuthCode()
    }
}
