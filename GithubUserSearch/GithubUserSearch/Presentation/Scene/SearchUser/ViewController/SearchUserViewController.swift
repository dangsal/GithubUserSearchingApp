//
//  SearchUserViewController.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/28.
//

import UIKit

final class SearchUserViewController: UIViewController {
    
    // MARK: - ui component
    
    private let searchUserView: SearchUserView = SearchUserView()
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = self.searchUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#if DEBUG
import SwiftUI

struct SearchUserViewController_PreView: PreviewProvider {
    static var previews: some View {
        let viewController = SearchUserViewController()
            viewController.toPreview()
    }
}
#endif
