//
//  VTURLSession.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import Alamofire

struct VTURLSession {
    let session: Session = {
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        let responseCacher = ResponseCacher(behavior: .cache)
        let networkLogger = VTNetworkLogger()
        let interceptor = VTRequestInterceptor()
        return Session(configuration: config,
                       interceptor: interceptor,
                       eventMonitors: [networkLogger])
    }()
    
    static func defaultSession() -> Session {
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        let responseCacher = ResponseCacher(behavior: .cache)
        let networkLogger = VTNetworkLogger()
        let interceptor = VTRequestInterceptor()
        return Session(configuration: config,
                       interceptor: interceptor,
                       cachedResponseHandler: responseCacher,
                       eventMonitors: [networkLogger])
    }
}
