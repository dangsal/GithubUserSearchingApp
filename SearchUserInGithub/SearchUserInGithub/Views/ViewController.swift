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
    
    private let viewModel: ViewModel = ViewModel()
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
        self.userSearchTextField.delegate = self
    }
    
    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: ImageLiterals.profile, style: .plain, target: self, action: #selector(didTapMyPageButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true
        self.configureByUserInterfaceStyle()
    }
    
    private func setBindings() {
        self.viewModel.$users
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
        if self.viewModel.isEmpty {
            self.userTableView.separatorStyle = .none
        }
        else {
            self.userTableView.separatorStyle = .singleLine
        }
    }
    
    private func configureByUserInterfaceStyle() {
        switch self.traitCollection.userInterfaceStyle {
        case .light:
            self.navigationItem.rightBarButtonItem?.tintColor = .black
        case .dark:
            self.navigationItem.rightBarButtonItem?.tintColor = .white
        default:
            return
        }
    }
    
    private func pushWebViewController(url: URL) {
        let viewController = WebViewController(url: url)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.configureByUserInterfaceStyle()
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
        if !viewModel.isEmpty {
            return viewModel.numberOfRowInSection(section)
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.configureTableView()
        if !viewModel.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.className, for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            let userViewModel = viewModel.userAtIndex(indexPath.row)
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
        let lastRowIndex = self.viewModel.users.count - 1
        if indexPath.row == lastRowIndex && indexPath.row != 0 && !self.viewModel.isLoading {
            self.viewModel.requestNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = self.viewModel.userUrlAtIndex(indexPath.row) else { return }
        
        self.pushWebViewController(url: url)
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty, text != self.viewModel.name {
            if text != self.viewModel.name {
                self.viewModel.resetCurrentPage()
            }
            self.viewModel.setName(name: text)
            let page = self.viewModel.currentPage
            self.viewModel.requestUser(user: text, page: page)
        }
        textField.resignFirstResponder()
        return true
    }
}
