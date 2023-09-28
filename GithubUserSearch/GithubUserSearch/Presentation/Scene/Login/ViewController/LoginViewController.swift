//
//  LoginViewController.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/29.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - ui component
    
    private let loginView: LoginView = LoginView()
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#if DEBUG
import SwiftUI

struct LoginViewController_PreView: PreviewProvider {
    static var previews: some View {
        let viewController = LoginViewController()
            viewController.toPreview()
    }
}
#endif
