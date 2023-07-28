//
//  VTAppDelegate.swift
//  Vault
//
//  Created by Kevin on 2023/7/28.
//  Copyright © 2023 Hut. All rights reserved.
//

import UIKit
import Foundation

class VTAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        debugPrint("AppLifeCycle: didFinishLaunchingWithOptions - From app delegate")
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        
        let config = UISceneConfiguration(name: "My Scene Delegate", sessionRole: connectingSceneSession.role)
        config.delegateClass = VTSceneDelegate.self
        return config
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        debugPrint("VTAppDelegate performActionFor shortcutItem: \(shortcutItem) ")
    }
}
