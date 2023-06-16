//
//  MyPageViewController.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import UIKit

import Then

final class MyPageViewController: UIViewController {
    
    // MARK: - ui component
    
    private let logoutButton: UIButton = UIButton(type: .system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("로그아웃", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.tintColor = .yellow
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
        self.view.addSubview(self.logoutButton)
        self.logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.logoutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.logoutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.logoutButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupButtonAction() {
        let logoutButtonDidTapAction = UIAction { [weak self] _ in
            self?.makeRequestAlert(title: "로그아웃",
                                   message: "로그아웃 하시겠습니까?",
                                   okTitle: "로그아웃",
                                   cancelTitle: "취소",
                                   okAction: { _ in
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                sceneDelegate.logout()
            })
        }
        self.logoutButton.addAction(logoutButtonDidTapAction, for: .touchUpInside)
    }
    
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.configureByUserInterfaceStyle()
    }
    
    private func configureByUserInterfaceStyle() {
        switch self.traitCollection.userInterfaceStyle {
        case .light:
            self.logoutButton.backgroundColor = .black
            self.logoutButton.tintColor = .white
            self.navigationController?.navigationBar.tintColor = .black
        case .dark:
            self.logoutButton.backgroundColor = .white
            self.logoutButton.tintColor = .black
            self.navigationController?.navigationBar.tintColor = .white
        default:
            return
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.configureByUserInterfaceStyle()
    }
}
