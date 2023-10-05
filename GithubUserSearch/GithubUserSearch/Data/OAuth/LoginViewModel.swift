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
//        let isLogin: AnyPublisher<Bool, Never>
    }
    
    // MARK: - property
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - init
    init() {
        
    }
    
    // MARK: - func
    
    func transform(from input: Input) -> Output {
        let isLogined = input.loginButtonDidTapEvent
            .sink { [weak self] _ in
                print("clicked here")
            }
            .store(in: &self.cancellable)
            
        
        return Output()
    }
}
