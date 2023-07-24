//
//  VTRouter.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//


import SwiftUI

struct VTImageCacheKey: EnvironmentKey {
    static let defaultValue: VTImageCache = VTTemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: VTImageCache {
        get { self[VTImageCacheKey.self] }
        set { self[VTImageCacheKey.self] = newValue }
    }
}
