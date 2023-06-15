//
//  EmptyView.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/16.
//

import UIKit

import Then

final class EmptyViewCell: UITableViewCell {
    
    // MARK: - ui componet
    
    private let emptyLabel: UILabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "해당 닉네임을 가진 유저가 없어요"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .systemGray
    }
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func setupLayout() {
        self.addSubview(self.emptyLabel)
        self.emptyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.emptyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}