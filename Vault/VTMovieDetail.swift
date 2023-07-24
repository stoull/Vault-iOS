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
            VStack {
                Text(movie.name)
                Spacer()
                Text(movie.synopsis ?? "")
            }
        }
    }
}

struct VTMovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        VTMovieDetail(movie: VTMovie.sampleMovie())
    }
}
