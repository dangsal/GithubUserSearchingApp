//
//  LoginView.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/29.
//

import Combine
import UIKit

import SnapKit

final class LoginView: UIView {
    
    // MARK: - ui component
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("깃허브로 로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = SizeLiteral.buttonCornerRadiusValue
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - property
    
    lazy var loginButtonDidTapEvent = self.loginButton.tapPublisher
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func setupLayout() {
        self.addSubview(self.loginButton)
        self.loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalToSuperview().inset(SizeLiteral.bottomPadding)
            $0.height.equalTo(60)
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .white
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct LoginViewPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = LoginView()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
