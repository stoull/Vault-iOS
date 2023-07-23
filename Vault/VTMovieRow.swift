//
//  VTMovieRow.swift
//  Vault
//
//  Created by Kevin on 2023/7/21.
//

import SwiftUI

struct VTMovieRow: View {
    var body: some View {
        HStack {
            VTMovieIconImage(imageName: "p2308392633.jpg")
                .padding(.leading)
            VStack {
                Text("name")
                    .fontWeight(.heavy)
                Text("detail")
            }
            Spacer()
        }
        
    }
}

struct VTMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        VTMovieRow()
    }
}
