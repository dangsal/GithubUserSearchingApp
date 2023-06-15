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
        $0.layer.cornerRadius = 8
        $0.placeholder = TextLiterals.userSearchTextField
        $0.returnKeyType = .search
        $0.addPadding()
        $0.addCustomClearButton()
    }
    private let userTableView: UITableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.className)
        $0.separatorInset.left = 0
    }
    
    // MARK: - property
    
    private let viewModel: ViewModel? = ViewModel()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupDelegation()
        self.configureUI()
        self.setupNavigationBar()
        self.hideKeyboardWhenTapped()
    }

    // MARK: - func
    
    private func setupLayout() {
        self.view.addSubview(self.userSearchTextField)
        self.userSearchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: SizeLiterals.topPadding).isActive = true
        self.userSearchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: SizeLiterals.leadingTrailingPadding).isActive = true
        self.userSearchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -SizeLiterals.leadingTrailingPadding).isActive = true
        self.userSearchTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.view.addSubview(self.userTableView)
        self.userTableView.topAnchor.constraint(equalTo: self.userSearchTextField.bottomAnchor, constant: 12).isActive = true
        self.userTableView.leadingAnchor.constraint(equalTo: self.userSearchTextField.leadingAnchor).isActive = true
        self.userTableView.trailingAnchor.constraint(equalTo: self.userSearchTextField.trailingAnchor).isActive = true
        self.userTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupDelegation() {
        self.userTableView.dataSource = self
        self.userTableView.delegate = self
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
    }
    
    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: ImageLiterals.profile, style: .plain, target: self, action: #selector(didTapMyPageButton))
        rightButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: - selector
    
    @objc
    private func didTapMyPageButton() {
        let viewController = MyPageViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.className, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
}
