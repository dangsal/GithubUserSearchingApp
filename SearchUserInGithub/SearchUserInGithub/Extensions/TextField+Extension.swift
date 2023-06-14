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
            $0.frame = CGRect(x: 0,
                              y: 0,
                              width: image.size.width,
                              height: image.size.height)
        }
        
        let clearButtonDidtap = UIAction { [weak self] _ in
            self?.text = ""
        }
        clearButton.addAction(clearButtonDidtap, for: .touchUpInside)
        
        rightView.addSubview(clearButton)

        self.rightView = rightView
        rightViewMode = .whileEditing
    }
}
