//
//  VTHostManager.swift
//  Vault
//
//  Created by Kevin on 2023/7/27.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation

struct VTHostManager {
    static let shared = VTHostManager()
    
    enum HostType {
        case home
        case work
        case internet
    }
    
    var hostType: VTHostManager.HostType = .internet
    
    var host: String {
        switch hostType {
        case .home:
            return "http://192.168.2.53:8000"
        case .work:
            return "http://hutpi.local:8000"
        case .internet:
            return "http://43.202.1.3:8000"
        }
    }
    
    var imageHost: String {
        switch hostType {
        case .home:
            return "http://hutpi.local:8000"
        case .work:
            return "http://hutpi.local:8000"
        case .internet:
            return "http://hutpi.local:8000"
        }
    }
    
    static func host(with hostType: VTHostManager.HostType) -> String {
        switch hostType {
        case .home:
            return "http://192.168.2.53:8000"
        case .work:
            return "http://hutpi.local:8000"
        case .internet:
            return "http://54.67.50.123:8000"
        }
    }

}
