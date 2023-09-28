//
//  SearchUserView.swift
//  GithubUserSearch
//
//  Created by 이성호 on 2023/09/28.
//

import UIKit

import SnapKit
import RxSwift

final class SearchUserView: UIView {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
