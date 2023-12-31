//
//  SearchUserView.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/28.
//

import Combine
import UIKit

import SnapKit
import RxSwift

final class SearchUserView: UIView {
    
    // MARK: - ui component
    
    private let userSearchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = SizeLiteral.textFieldCornerRadiusValue
        textField.placeholder = TextLiterals.userSearchTextField
        textField.returnKeyType = .search
        textField.addPadding()
        textField.addCustomClearButton()
        return textField
    }()
    private let userTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.className)
        tableView.register(EmptyViewCell.self, forCellReuseIdentifier: EmptyViewCell.className)
        tableView.separatorInset.left = 0
        return tableView
    }()
    
    private lazy var users: [UserInfo] = mockData
    // MARK: - fixme
    let mockData = [UserInfo(login: "s", avatarURL: "sdfs", url: "sdf"), UserInfo(login: "sdfasf", avatarURL: "sdfasdfasdfa", url: "sdfasdfkmvn")]
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.setupLayout()
        self.setupDelegation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(self.userSearchTextField)
        self.userSearchTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(SizeLiteral.userSearchTextFieldHeight)
        }
        
        self.addSubview(self.userTableView)
        self.userTableView.snp.makeConstraints {
            $0.top.equalTo(self.userSearchTextField.snp.bottom).offset(SizeLiteral.padding)
            $0.leading.trailing.equalTo(self.userSearchTextField)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupDelegation() {
        self.userTableView.dataSource = self
        self.userTableView.delegate = self
        self.userSearchTextField.delegate = self
    }
    
    func configureNavigationBar(_ navigationController: UINavigationController) {
        navigationController.navigationItem.hidesBackButton = true
    }
}

// MARK: - UITableViewDataSource
extension SearchUserView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.users.isEmpty {
            return 1
        } else {
            return self.users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.users.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyViewCell.className, for: indexPath) as? EmptyViewCell else { return UITableViewCell() }
            tableView.separatorStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.className, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
            tableView.separatorStyle = .singleLine
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SizeLiteral.tableViewCellHight
    }
}

// MARK: - UITableViewDelegate
extension SearchUserView: UITableViewDelegate {
    
}

// MARK: - UITextFieldDelegate
extension SearchUserView: UITextFieldDelegate {
    
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SearchUserViewPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = SearchUserView()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
