//
//  UIImage+UI.swift
//  GithubUserSearch
//
//  Created by 이성호 on 10/6/23.
//

import UIKit

extension UIImage {
    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName) else {
            return UIImage()
        }
        return image
    }
}
