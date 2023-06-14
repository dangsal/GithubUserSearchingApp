//
//  UserTableViewCell.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import UIKit

import Then

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - ui compoent
    
    private let userImageView: UIImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 22
    }
    private let userNameLabel: UILabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "이성호"
    }
    private let userUrlLabel: UILabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "shdkflsakjdfasdfasdfasdfasdf"
    }
    
    // MARK: - property
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        userNameLabel.text = nil
        userUrlLabel.text = nil
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.userImageView)
        self.userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.userImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.userImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.contentView.addSubview(self.userNameLabel)
        self.userNameLabel.topAnchor.constraint(equalTo: self.userImageView.topAnchor).isActive = true
        self.userNameLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 12).isActive = true
        self.userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        self.contentView.addSubview(self.userUrlLabel)
        self.userUrlLabel.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 4).isActive = true
        self.userUrlLabel.leadingAnchor.constraint(equalTo: self.userNameLabel.leadingAnchor).isActive = true
        self.userUrlLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func configureUserInformation(user: User) {
        
    }
}

struct User {
    
}
