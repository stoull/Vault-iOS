//
//  VTTools.swift
//  Vault
//
//  Created by Stoull Hut on 2023/7/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    /// 结束编辑
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

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
