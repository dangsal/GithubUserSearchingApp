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
        $0.placeholder = TextLiterals.userSearchTextField
        $0.addPadding()
    }
    private let searchImageView: UIImageView = UIImageView(image: ImageLiterals.searchImage).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .gray
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
        self.userSearchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: SizeLiterals.topPadding).isActive = true
        self.userSearchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: SizeLiterals.leadingTrailingPadding).isActive = true
        self.userSearchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -SizeLiterals.leadingTrailingPadding).isActive = true
        self.userSearchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.userSearchTextField.addSubview(self.searchImageView)
        self.searchImageView.trailingAnchor.constraint(equalTo: self.userSearchTextField.trailingAnchor, constant: -10).isActive = true
        self.searchImageView.centerYAnchor.constraint(equalTo: self.userSearchTextField.centerYAnchor).isActive = true
        self.searchImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.searchImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
}

