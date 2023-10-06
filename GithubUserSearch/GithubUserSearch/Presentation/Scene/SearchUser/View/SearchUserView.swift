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
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.setupLayout()
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
    }
    
    func configureNavigationBar(_ navigationController: UINavigationController) {
        navigationController.navigationItem.hidesBackButton = true
    }
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
