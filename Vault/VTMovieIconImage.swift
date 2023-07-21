//
//  VTMovieImage.swift
//  Vault
//
//  Created by Kevin on 2023/7/21.
//

import SwiftUI

struct VTMovieIconImage: View {
    var image: Image
    
    var imageName: String?
    
    init(image: Image) {
        self.image = image
    }
    
    
    
    init(imageName: String) {
        self.imageName = imageName
        self.image = Image("liandang")
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            image
                .frame(width: 160.0, height: 160.0)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 2.0)
                }
                .shadow(radius: 8)
        } else {
            image.frame(width: 160.0, height: 160.0)
                .cornerRadius(8.0)
                .shadow(radius: 8.0)
        }
    }
    
    func loadImage(imageName: String) {
        guard imageName.count > 0 else { return }
        VTMovieStore.shared.loadImage(urlString: "http://192.168.1.200:5000/images/poster/" + imageName).sink { completion in
            print("加载图片 completion: \(completion)")
        } receiveValue: { imgData in
            
        }.store(in: &subscriptions)
    }
    
//    func URLSession.shared.dataTaskPublisher(for: "http://192.168.1.200:5000/images/poster/p812857342.jpg")
}

struct VTMovieImage_Previews: PreviewProvider {
    static var previews: some View {
        VTMovieIconImage(image: Image("liandang"))
    }
}
