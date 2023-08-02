//
//  VTRouter.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//


import SwiftUI

struct VTMovieDetail: View {
    var movie: VTMovie
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let posterName = movie.poster_name {
                    VTMovieIconImage<Text>(imageName: posterName)
                        .frame(width: 120, alignment: .center)
                }
                Text(movie.name)
//                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                Text(movie.synopsis ?? "")
                Text("是否已下载：\(movie.is_downloaded)")
                Text("位置：\(movie.filePath ?? "")")
            }.navigationTitle(movie.name)
        }
    }
}

struct VTMovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        VTMovieDetail(movie: VTMovie.sampleMovie())
    }
}
