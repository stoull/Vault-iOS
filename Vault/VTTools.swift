//
//  VTTools.swift
//  Vault
//
//  Created by Stoull Hut on 2023/7/21.
//

import Foundation
import SwiftUI

struct VTTools {
    // data 转image
    static func createImage(_ value: Data) -> Image {
    #if canImport(UIKit)
        let songArtwork: UIImage = UIImage(data: value) ?? UIImage()
        return Image(uiImage: songArtwork)
    #elseif canImport(AppKit)
        let songArtwork: NSImage = NSImage(data: value) ?? NSImage()
        return Image(nsImage: songArtwork)
    #else
        return Image(systemImage: "play.tv")
    #endif
    }
}
