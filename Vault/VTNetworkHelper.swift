//
//  VTNetworkHelper.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation

struct VTNetworkHelper {
    var reachability = try? VTReachability()
    
    /// 当前是否是有网络连接
    var isCurrentedToNetwork: Bool {
        get {
            switch reachability?.connection {
            case .wifi, .cellular:
                return true
            case .unavailable:
                return false
            default:
                return false
            }
        }
    }
    
    /// 当前是否是使用WiFi网络
    var isCurrentConnectToWiFi: Bool {
        get {
            switch reachability?.connection {
            case .wifi:
                return true
            case .cellular, .unavailable:
                return false
            default:
                return false
            }
        }
    }
}
