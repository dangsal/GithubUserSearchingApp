//
//  LoginViewController.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import UIKit

import Then

final class LoginViewController: UIViewController {
    
    // MARK: - ui component
    
    private let loginButton: UIButton = UIButton(type: .system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("깃 허브로 로그인", for: .normal)
        $0.backgroundColor = .systemGray
        $0.tintColor = .white
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupButtonAction()
        self.configureUI()
    }
    
    // MARK: - func
    
    private func setupLayout() {
        self.view.addSubview(self.loginButton)
        self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.loginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupButtonAction() {
        let loginButtonDidTapAction = UIAction { [weak self] _ in
            self?.requestOAuthCode()
        }
        self.loginButton.addAction(loginButtonDidTapAction, for: .touchUpInside)
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true
        self.configureByUserInterfaceStyle()
    }
    
    private func requestOAuthCode() {
        let apiManager = GithubOAuthManager.shared
        apiManager.requestAuthCode()
    }
    
    private func configureByUserInterfaceStyle() {
        switch self.traitCollection.userInterfaceStyle {
        case .light:
            self.loginButton.backgroundColor = .black
            self.loginButton.tintColor = .white
        case .dark:
            self.loginButton.backgroundColor = .white
            self.loginButton.tintColor = .black
        default:
            return
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.configureByUserInterfaceStyle()
    }
}
