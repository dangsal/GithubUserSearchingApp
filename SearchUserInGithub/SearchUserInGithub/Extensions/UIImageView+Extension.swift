//
//  UIImageView+Extension.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/15.
//

import Foundation
import UIKit

extension UIImageView {
    func load(from url: String) {
        
        let cacheKey = NSString(string: url)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageUrl = URL(string: url),
               let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        self?.image = image
                    }
                }
            }
        }
    }
}
