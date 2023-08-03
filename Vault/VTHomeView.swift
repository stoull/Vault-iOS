//
//  VTHomeView.swift
//  Vault
//
//  Created by Kevin on 2023/7/19.
//

import SwiftUI
import Combine

struct VTHomeView: View {
    @State private var keywords: String = ""
    @State private var movies:[VTMovie] = []
    @State private var isHideLoader: Bool = true
    @State private var isShowErrorAlert: Bool = false
    @State private var errorAlertMessage: String = ""
    
    let backgroundGradient = LinearGradient(
        colors: [Color(hex: "#FBEAFF"), Color(hex: "#C4FCEF")],
        startPoint: .leading, endPoint: .trailing)
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    Image("vault120")
                    Text("Vault-all for movies")
                }
                .frame(maxWidth: .infinity)
                HStack {
                    if #available(iOS 15.0, *) {
                        TextField(
                            "输入关键字",
                            text: $keywords
                        ){
                            // Called when the user tap the return button
                            startSearch()
                        }
                        .submitLabel(.search)
                        .frame(height: 40)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 6))
                    } else {
                        // Fallback on earlier versions
                        TextField(
                            "输入关键字",
                            text: $keywords
                        ){
                            // Called when the user tap the return button
                            startSearch()
                        }
                        .keyboardType(.webSearch)
                        .frame(height: 40)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 6))
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
                    .padding(.trailing, 12)
                }
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(backgroundGradient))
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).strokeBorder(Color(hex: "#C34A36"), lineWidth: 1))
                .padding()
                
                ForEach(movies) { movie in
                    NavigationLink {
                        VTMovieDetail(movie: movie)
                    } label: {
                        VTMovieRow(movie: movie)
//                        Text(movie.name)
                    }
                    .frame(height: 80)
                }
            }
            .navigationTitle("Vault")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Image("vault120")
//                }
//            }
            .navigationBarHidden(true)
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
                if movies.count == 0 {
                    errorAlertMessage = "the count is 0"
                    isShowErrorAlert = true
                }
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

struct VTHomeView_Previews: PreviewProvider {
    static var previews: some View {
        VTHomeView()
    }
}
