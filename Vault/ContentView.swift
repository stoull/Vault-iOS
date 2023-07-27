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
    @State private var isHideLoader: Bool = true
    @State private var isShowErrorAlert: Bool = false
    @State private var errorAlertMessage: String = ""
    
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
                        ){
                            // Called when the user tap the return button
                            startSearch()
                        }
                        
                        VTLoaderView(tintColor: .blue, scaleSize: 1.0)
                            .padding()
                            .hidden(isHideLoader)
                        
                        Button {
                            print("search keywords : \(keywords)")
                            startSearch()
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
                    .frame(height: 44)
                }
            }
            .navigationTitle("Vault")
            .onAppear() {
                //            testCombineSubscription()
                //            testCombineSubject()
            }
            .gesture(DragGesture().onChanged { _ in
                UIApplication.shared.endEditing()
            })
            .alert(isPresented: $isShowErrorAlert) {
                Alert(title: Text("Not found!"),
                      message: Text(errorAlertMessage),
                      dismissButton: .default(Text("Okay"), action: {}))
            }
        }
    }
    
    func startSearch() {
        guard keywords.count > 0 else { return }
        UIApplication.shared.endEditing()
        self.searchMovie(keywords: keywords)
    }
    
    func searchMovie(keywords: String) {
        isHideLoader = false
        VTMovieStore.shared.searchMovies(keywords: keywords).sink(receiveCompletion: { completion in
            
            isHideLoader = true
            switch completion {
            case .finished:
                ()
            case .failure(let error):
                errorAlertMessage = error.localizedDescribiption
                isShowErrorAlert = true
            }
            
            print("搜索: \(keywords) completion: \(completion)")
        }, receiveValue: { searchResult in
            isHideLoader = true
            movies = searchResult
        })
        .store(in: &subscriptions)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
