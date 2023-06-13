//
//  ViewController.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import Combine
import UIKit

import CombineMoya
import Moya
import Then


final class ViewController: UIViewController {
    
    // MARK: - ui component
    
    private let userSearchTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.placeholder = TextLiteral.userSearchTextField
    }
    
    // MARK: - property
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }

    // MARK: - func
    
    private func setupLayout() {
        self.view.addSubview(self.userSearchTextField)
        self.userSearchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: SizeLiteral.topPadding).isActive = true
        self.userSearchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: SizeLiteral.leadingTrailingPadding).isActive = true
        self.userSearchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -SizeLiteral.leadingTrailingPadding).isActive = true
        self.userSearchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}

