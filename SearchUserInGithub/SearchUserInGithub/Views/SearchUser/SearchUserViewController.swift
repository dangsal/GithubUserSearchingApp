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


final class SearchUserViewController: UIViewController {
    
    // MARK: - ui component
    
    private let userSearchTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.layer.cornerRadius = 8
        $0.placeholder = TextLiterals.userSearchTextField
        $0.returnKeyType = .search
        $0.addPadding()
        $0.addCustomClearButton()
    }
    private let userTableView: UITableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.className)
        $0.register(EmptyViewCell.self, forCellReuseIdentifier: EmptyViewCell.className)
        $0.separatorInset.left = 0
    }
    
    // MARK: - property
    
    private let searchUserViewModel: SearchUserViewModel = SearchUserViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupDelegation()
        self.setupNavigationBar()
        self.configureUI()
        self.setBindings()
        self.hideKeyboardWhenTapped()
    }

    // MARK: - func
    
     private func setupLayout() {
        self.view.addSubview(self.userSearchTextField)
        self.userSearchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: SizeLiterals.topPadding).isActive = true
        self.userSearchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: SizeLiterals.leadingTrailingPadding).isActive = true
        self.userSearchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -SizeLiterals.leadingTrailingPadding).isActive = true
         self.userSearchTextField.heightAnchor.constraint(equalToConstant: SizeLiterals.userSearchTextFieldHeight).isActive = true
        
        self.view.addSubview(self.userTableView)
         self.userTableView.topAnchor.constraint(equalTo: self.userSearchTextField.bottomAnchor, constant: SizeLiterals.padding).isActive = true
        self.userTableView.leadingAnchor.constraint(equalTo: self.userSearchTextField.leadingAnchor).isActive = true
        self.userTableView.trailingAnchor.constraint(equalTo: self.userSearchTextField.trailingAnchor).isActive = true
        self.userTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupDelegation() {
        self.userTableView.dataSource = self
        self.userTableView.delegate = self
        self.userSearchTextField.delegate = self
    }
    
    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: ImageLiterals.logout, style: .plain, target: self, action: #selector(didTapLogoutButton))
        rightButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true
    }
    
    private func setBindings() {
        self.searchUserViewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadTableView()
            }
            .store(in: &self.cancellable)
    }
    
    private func reloadTableView() {
        self.userTableView.reloadData()
    }
    
    private func configureTableView() {
        if self.searchUserViewModel.isEmpty {
            self.userTableView.separatorStyle = .none
        }
        else {
            self.userTableView.separatorStyle = .singleLine
        }
    }
    
    private func pushWebViewController(url: URL) {
        let viewController = WebViewController(url: url)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - selector
    
    @objc
    private func didTapLogoutButton() {
        self.makeRequestAlert(title: TextLiterals.logoutText,
                              message: TextLiterals.logoutMessage,
                              okTitle: TextLiterals.logoutText,
                              okAction: { _ in
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            sceneDelegate.logout()
        })
    }
}

// MARK: - UITableViewDataSource

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchUserViewModel.isEmpty {
            return searchUserViewModel.numberOfRowInSection(section)
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.configureTableView()
        if !searchUserViewModel.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.className, for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            let userViewModel = searchUserViewModel.userAtIndex(indexPath.row)
            cell.configureUserInformation(user: userViewModel)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyViewCell.className, for: indexPath) as? EmptyViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = self.searchUserViewModel.users.count - 1
        if indexPath.row == lastRowIndex && indexPath.row != 0 && !self.searchUserViewModel.isLoading {
            self.searchUserViewModel.requestNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SizeLiterals.tableViewCellHight
    }
}

// MARK: - UITableViewDelegate

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = self.searchUserViewModel.userUrlAtIndex(indexPath.row) else { return }
        
        self.pushWebViewController(url: url)
    }
}

// MARK: - UITextFieldDelegate

extension SearchUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty, text != self.searchUserViewModel.name {
            if text != self.searchUserViewModel.name {
                self.searchUserViewModel.resetCurrentPage()
            }
            self.searchUserViewModel.setName(name: text)
            let page = self.searchUserViewModel.currentPage
            self.searchUserViewModel.requestUser(user: text, page: page)
        }
        textField.resignFirstResponder()
        return true
    }
}
