//
//  VTSceneDelegate.swift
//  Vault
//
//  Created by Kevin on 2023/7/28.
//  Copyright © 2023 Hut. All rights reserved.
//

import UIKit

class VTSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("MySceneDelegate: connecting scene")
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("MySceneDelegate: performActionFor shortcutItem: \(shortcutItem)")
    }
}
