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
        .onAppear {
            testCombineSubscription()
            testCombineSubject()
            
            _ = VTMovieStore.shared.searchMovies(keywords: "音乐").sink { (completion) in
                print("搜索音乐 completion: \(completion)")
            } receiveValue: { searchResponse in
                print("searchResponse: \(searchResponse)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
