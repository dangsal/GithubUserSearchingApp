//
//  LoginViewController.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/29.
//

import Combine
import UIKit

import RxCocoa
import RxSwift

final class LoginViewController: UIViewController {
    
    // MARK: - ui component
    
    private let loginView: LoginView = LoginView()
    
    // MARK: - property
    
    private let viewModel: LoginViewModel
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindToViewModel()
    }
    
    // MARK: - func
    
    private func bindToViewModel() {
        let output = self.transformedOutput()
        self.bindOutputToViewModel(output)
    }
    
    private func transformedOutput() -> LoginViewModel.Output {
        let input = LoginViewModel.Input(loginButtonDidTapEvent: self.loginView.loginButtonDidTapEvent)
        return self.viewModel.transform(from: input)
    }
    
    private func bindOutputToViewModel(_ ouput: LoginViewModel.Output) {
        
    }
}

#if DEBUG
import SwiftUI

struct LoginViewController_PreView: PreviewProvider {
    static var previews: some View {
        let viewController = LoginViewController(viewModel: LoginViewModel())
            viewController.toPreview()
    }
}
#endif
