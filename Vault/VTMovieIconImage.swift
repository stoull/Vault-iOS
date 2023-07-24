//
//  VTMovieImage.swift
//  Vault
//
//  Created by Kevin on 2023/7/21.
//

import SwiftUI

struct VTMovieIconImage<Placeholder: View>: View {
    @StateObject private var loader: VTImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    // fetch image from url with image name
    var imageName: String?
    
    init(imageName: String) {
        var rImageName = imageName
        if imageName.count < 1 {
            rImageName = ""
        }
//        let imgStr = "http://192.168.0.101:5001/images/poster/" + rImageName
        let imgStr = "http://192.168.2.53:5000/images/poster/" + rImageName
        
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
                if #available(iOS 15.0, *) {
                    image(loader.image!)
                        .frame(width: 120.0, height: 120.0)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 2.0)
                        }
                        .shadow(radius: 8)
                } else {
                    image(loader.image!)
                        .frame(width: 120.0, height: 120.0)
                        .cornerRadius(8.0)
                        .shadow(radius: 8.0)
                }
            } else {
                placeholder
            }
        }.onAppear(perform: loader.load)
    }
//    func URLSession.shared.dataTaskPublisher(for: "http://192.168.1.200:5000/images/poster/p812857342.jpg")
}

//struct VTMovieImage_Previews: PreviewProvider {
//    static var previews: some View {
//        VTMovieIconImage(imageName: "p2308392633.jpg")
//    }
//}
