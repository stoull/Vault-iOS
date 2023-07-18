//
//  VaultApp.swift
//  Vault
//
//  Created by Kevin on 2023/7/18.
//

import SwiftUI

@main
struct VaultApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
