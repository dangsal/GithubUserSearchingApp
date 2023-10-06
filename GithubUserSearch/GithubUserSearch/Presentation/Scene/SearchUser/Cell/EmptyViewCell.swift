//
//  EmptyViewCell.swift
//  GithubUserSearch
//
//  Created by 이성호 on 10/6/23.
//

import UIKit

import SnapKit

final class EmptyViewCell: UITableViewCell {
    
    // MARK: - ui component
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = TextLiterals.emptyViewLabel
        label.textColor = .systemGray
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
        self.addSubview(self.emptyLabel)
        self.emptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiteral.topPadding)
            $0.centerX.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct EmptyViewCellPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = EmptyViewCell()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
