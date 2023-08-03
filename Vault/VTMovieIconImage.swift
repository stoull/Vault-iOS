//
//  VTMovieImage.swift
//  Vault
//
//  Created by Kevin on 2023/7/21.
//

import SwiftUI

struct VTMoviePosterImage<Placeholder: View>: View {
    @StateObject private var loader: VTImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    // fetch image from url with image name
    var posterName: String?
    
    init(posterName: String) {
        var rImageName = posterName
        if posterName.count < 1 {
            rImageName = ""
        }
        let imgStr = VTHostManager.shared.imageHost + "/images/poster/" + rImageName
        self.init(url: URL(string: imgStr)!,
                  placeholder: { Text("Loading ...") as! Placeholder },
                  image: { Image(uiImage: $0).resizable() }
        )
    }
    
    init(url: URL,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: VTImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content.onAppear(perform: loader.load)
    }
    
    private var content: some View {
        VStack {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }.onAppear(perform: loader.load)
    }
}

//struct VTMovieImage_Previews: PreviewProvider {
//    static var previews: some View {
//        VTMoviePosterImage(imageName: "p2308392633.jpg")
//    }
//}
