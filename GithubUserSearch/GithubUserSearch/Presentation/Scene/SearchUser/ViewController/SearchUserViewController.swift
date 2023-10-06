//
//  SearchUserViewController.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/28.
//

import Combine
import UIKit

final class SearchUserViewController: UIViewController {
    
    // MARK: - ui component
    
    private let searchUserView: SearchUserView = SearchUserView()
    
    // MARK: - property
    
    private let viewModel: SearchUserViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: SearchUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = self.searchUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        guard let navigationController = self.navigationController else { return }
        self.searchUserView.configureNavigationBar(navigationController)
    }
}

#if DEBUG
import SwiftUI

struct SearchUserViewController_PreView: PreviewProvider {
    static var previews: some View {
        let viewController = SearchUserViewController(viewModel: SearchUserViewModel())
            viewController.toPreview()
    }
}
#endif
