//
//  UITextField+UI.swift
//  GithubUserSearch
//
//  Created by 이성호 on 10/6/23.
//

import UIKit

//import Then

extension UITextField {
    func addPadding() {
        let image = ImageLiteral.magnifyingglass
        let leftView: UIView = UIView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: image.size.width + 20,
                                                    height: image.size.height))
        let iconView: UIImageView = UIImageView(frame: CGRect(x: 10,
                                                              y: 0,
                                                              width: image.size.width,
                                                              height: image.size.height))
        iconView.image = image
        iconView.tintColor = .gray
        iconView.contentMode = .center
    
        
        leftView.addSubview(iconView)
        
        self.leftView = leftView
        self.leftViewMode = .always

    }
    
    func addCustomClearButton() {
        let image = ImageLiteral.xmark
        let rightView: UIView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: image.size.width + 30,
                                                     height: image.size.height + 30))
        let clearButton: UIButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.tintColor = .gray
        clearButton.isHidden = true
        clearButton.frame = CGRect(x: 0,
                              y: 0,
                              width: rightView.bounds.size.width,
                              height: rightView.bounds.size.height)
        
        
        let clearButtonDidtap = UIAction { [weak self] _ in
            self?.text = ""
            self?.rightView?.subviews.first?.isHidden = true
        }
        let textDidChange = UIAction { [weak self] _ in
            self?.rightView?.subviews.first?.isHidden = self?.text?.isEmpty ?? true
        }
        
        clearButton.addAction(clearButtonDidtap, for: .touchUpInside)
        
        self.addAction(textDidChange, for: .editingChanged)
        rightView.addSubview(clearButton)
        
        self.rightView = rightView
        rightViewMode = .whileEditing
    }
}
