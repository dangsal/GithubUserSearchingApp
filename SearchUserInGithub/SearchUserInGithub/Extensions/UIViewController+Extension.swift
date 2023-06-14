//
//  UIViewController.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditingView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func endEditingView() {
        view.endEditing(true)
    }
}
