//
//  UserTableViewCell.swift
//  GithubUserSearch
//
//  Created by 이성호 on 10/6/23.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - ui component
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.userDefaultProfile
        imageView.tintColor = .gray
        imageView.layer.cornerRadius = SizeLiteral.imageCornerRadiusValue
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "userNameLabel"
        return label
    }()
    private let userUrlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "userUrlLabel"
        return label
    }()
    
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
        self.contentView.addSubview(self.userImageView)
        self.userImageView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.width.height.equalTo(SizeLiteral.userImageSize)
        }
        
        self.contentView.addSubview(self.userNameLabel)
        self.userNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.userImageView.snp.top)
            $0.leading.equalTo(self.userImageView.snp.trailing).offset(SizeLiteral.padding)
            $0.trailing.equalToSuperview()
        }
        
        self.contentView.addSubview(self.userUrlLabel)
        self.userUrlLabel.snp.makeConstraints {
            $0.top.equalTo(self.userNameLabel.snp.bottom)
            $0.leading.equalTo(self.userNameLabel.snp.leading)
            $0.trailing.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UserTableViewCellPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = UserTableViewCell()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
