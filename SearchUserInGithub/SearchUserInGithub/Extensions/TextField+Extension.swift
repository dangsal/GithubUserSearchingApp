//
//  TextField+Extension.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import UIKit

extension UITextField {
    func addPadding() {
        let leftView: UIView = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: 10,
                                                height: self.frame.size.height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
}
