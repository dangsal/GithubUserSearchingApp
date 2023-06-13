//
//  NSObject+Extension.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
