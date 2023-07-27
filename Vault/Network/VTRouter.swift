//
//  VTRouter.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import Alamofire

enum VTRouter {
    case searchMovie(keywords: String)
    
    var baseURL: String {
        return VTHostManager.host(with: .internet)
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/api/v1/movies/search"
        }
    }
}
