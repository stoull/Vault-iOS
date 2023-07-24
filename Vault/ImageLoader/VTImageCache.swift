//
//  VTRouter.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import UIKit

protocol VTImageCache {
    subscript(_ url: URL) -> UIImage? {get set}
}

struct VTTemporaryImageCache: VTImageCache {
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100      // 100 itmes
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set {
            newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL)
        }
    }
}
