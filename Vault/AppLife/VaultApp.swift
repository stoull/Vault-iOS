//
//  VaultApp.swift
//  Vault
//
//  Created by Kevin on 2023/7/19.
//

import SwiftUI

@main
struct VaultApp: App {
    
    @UIApplicationDelegateAdaptor(VTAppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        debugPrint("AppLifeCycle: VaultApp init")
    }
    
    var body: some Scene {
        WindowGroup {
            VTHomeView()
                .onOpenURL { url in
                    // handler Universal Links and NSUserActivity
                openAppURL(url: url)
            }
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                debugPrint("AppLifeCycle: app is active")
            case .inactive:
                debugPrint("AppLifeCycle: app is inactive")
            case .background:
                debugPrint("AppLifeCycle: app is switch in background")
            @unknown default:
                debugPrint("AppLifeCycle: something new added by apple")
            }
        }
    }
    
    private func openAppURL(url: URL) {
        // handler Universal Links and NSUserActivity
        
        print("App did didReceive url: \(url.absoluteString)")
    }
}
