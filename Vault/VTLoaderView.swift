//
//  VTLoaderView.swift
//  Vault
//
//  Created by Kevin on 2023/7/27.
//  Copyright © 2023 Hut. All rights reserved.
//

import SwiftUI

struct VTLoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    var textString: String = ""
    
    var body: some View {
        ProgressView() {
                if textString.count > 0 {
                    Text(textString)
                    .foregroundColor(tintColor)
                }
            }
        .scaleEffect(scaleSize, anchor: .center)
        .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
        
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

struct VTLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        VTLoaderView()
    }
}
