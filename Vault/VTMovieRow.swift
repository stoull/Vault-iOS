//
//  VTMovieRow.swift
//  Vault
//
//  Created by Kevin on 2023/7/21.
//

import SwiftUI

struct VTMovieRow: View {
    var movie: VTMovie
    
    var body: some View {
        HStack() {
            if let posterName = movie.poster_name {
                VTMoviePosterImage<Text>(posterName: posterName)
                    .frame(width: 60, alignment: .leading)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8.0)
                    .shadow(radius: 8.0)
            }
            VStack {
                Text(movie.name)
                    .font(.title3)
                if let syno = movie.synopsis {
                    Text(syno)
                        .font(.system(size: 14.0))
                }
            }
            Spacer()
        }
    }
}

struct VTMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        VTMovieRow(movie: VTMovie.sampleMovie())
    }
}
