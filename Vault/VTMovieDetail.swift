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
        VStack(alignment: .leading) {
            Text(movie.name)
                .lineLimit(4)
            HStack {
                if let posterName = movie.poster_name {
                    Spacer()
                    VTMoviePosterImage<Text>(posterName: posterName)
                        .frame(alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(4.0)
                    Spacer()
                }
            }
            
//                Text(movie.name)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .font(.title)
            Text(movie.synopsis ?? "")
            Text("是否已下载：\(movie.is_downloaded)")
            Text("位置：\(movie.filePath ?? "")")
        }
        .navigationBarTitle(movie.name, displayMode: .inline)
    }
}

struct VTMovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        VTMovieDetail(movie: VTMovie.sampleMovie())
    }
}
