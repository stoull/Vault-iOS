//
//  ContentView.swift
//  Vault
//
//  Created by Kevin on 2023/7/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "play.tv")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Vault-all for movies")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
