//
//  NSObject+Extension.swift
//  GithubUserSearch
//
//  Created by 이성호 on 10/6/23.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
