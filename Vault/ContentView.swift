//
//  ContentView.swift
//  Vault
//
//  Created by Kevin on 2023/7/19.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var keywords: String = ""
    @State private var movies:[VTMovie] = []
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Image(systemName: "play.tv")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Vault-all for movies")
                    HStack {
                        TextField(
                                "输入关键字",
                                text: $keywords
                        )
                        
                        Button {
                            print("search : \(keywords)")
                            
                            self.searchMovie(keywords: keywords)
                        } label: {
                            Text("Search")
                        }
                    }
                    
                }
                .padding()
                
                ForEach(movies) { movie in
                    NavigationLink {
                        VTMovieDetail(movie: movie)
                    } label: {
                        Text(movie.name)
                    }
                }
            }
            .navigationTitle("Vault")
            .onAppear() {
                //            testCombineSubscription()
                //            testCombineSubject()
            }
            
        }
    }
    
    func searchMovie(keywords: String) {
        guard keywords.count > 0 else { return }
        VTMovieStore.shared.searchMovies(keywords: keywords).sink(receiveCompletion: { completion in
            print("搜索: \(keywords) completion: \(completion)")
        }, receiveValue: { searchResult in
            movies = searchResult
            print("searchResponse: \(searchResult)")
        })
        .store(in: &subscriptions)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
