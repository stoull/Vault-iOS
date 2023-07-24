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
        HStack {
            if let posterName = movie.poster_name {
                VTMovieIconImage<Text>(imageName: posterName)
                    .padding(.leading)
            }
            VStack {
                Text(movie.name)
                    .fontWeight(.heavy)
                if let syno = movie.synopsis {
                    Text(syno)
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
