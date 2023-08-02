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
                if #available(iOS 15.0, *) {
                    VTMovieIconImage<Text>(imageName: posterName)
                        .frame(width: 120.0, height: 120.0)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 2.0)
                        }
                        .shadow(radius: 8)
                        .padding(.leading)
                } else {
                    VTMovieIconImage<Text>(imageName: posterName)
                        .frame(width: 120.0, height: 120.0)
                        .cornerRadius(8.0)
                        .shadow(radius: 8.0)
                        .padding(.leading)
                }
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
