//
//  TextField+Extension.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import UIKit

import Then

extension UITextField {
    func addPadding() {
        let image = ImageLiterals.magnifyingglass
        let leftView: UIView = UIView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: image.size.width + 20,
                                                    height: image.size.height))
        let iconView: UIImageView = UIImageView(frame: CGRect(x: 10,
                                                              y: 0,
                                                              width: image.size.width,
                                                              height: image.size.height)).then {
            $0.image = image
            $0.tintColor = .gray
            $0.contentMode = .center
        }
        
        leftView.addSubview(iconView)
        
        self.leftView = leftView
        self.leftViewMode = .always

    }
    
    func addCustomClearButton() {
        let image = ImageLiterals.xmark
        let rightView: UIView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: image.size.width + 10,
                                                     height: image.size.height))
        let clearButton: UIButton = UIButton(type: .custom).then {
            $0.setImage(image, for: .normal)
            $0.tintColor = .gray
            $0.isHidden = true
            $0.frame = CGRect(x: -15,
                              y: -10,
                              width: image.size.width + 20,
                              height: image.size.height + 20)
        }
        
        let clearButtonDidtap = UIAction { [weak self] _ in
            self?.text = ""
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
