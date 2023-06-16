//
//  ImageCacheManager.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
