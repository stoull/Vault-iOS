//
//  VTMovieImage.swift
//  Vault
//
//  Created by Kevin on 2023/7/21.
//

import SwiftUI

struct VTMovieIconImage: View {
    @State private var image: Image
    
    // fetch image from url with image name
    var imageName: String?
    
    init() {
        self.image = Image("liandang")
    }
    
    init(image: Image) {
        self.image = image
    }
    
    init(imageName: String) {
        self.image = Image("liandang")
        self.imageName = imageName
        loadImage(imageName: imageName)
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            image
                .frame(width: 120.0, height: 120.0)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 2.0)
                }
                .shadow(radius: 8)
        } else {
            image.frame(width: 120.0, height: 120.0)
                .cornerRadius(8.0)
                .shadow(radius: 8.0)
        }
    }
    
    func loadImage(imageName: String) {
        guard imageName.count > 0 else { return }
        let imgStr = "http://192.168.0.101:5001/images/poster/" + imageName
        debugPrint("xxx loadImage imageStr: \(imgStr)")
        VTMovieStore.shared.loadImage(urlString: imgStr).sink { completion in
            print("加载图片 completion: \(completion)")
        } receiveValue: { img in
            print("loadImage 成功！")
            DispatchQueue.main.async {
                image = img
            }
        }
        .store(in: &subscriptions)
    }
    
//    func URLSession.shared.dataTaskPublisher(for: "http://192.168.1.200:5000/images/poster/p812857342.jpg")
}

struct VTMovieImage_Previews: PreviewProvider {
    static var previews: some View {
        VTMovieIconImage(imageName: "p2308392633.jpg")
    }
}
