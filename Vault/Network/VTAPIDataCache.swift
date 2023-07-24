//
//  VTAPIDataCache.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct VTAPIDataCache {
    static func receivedJSON<T: VTResponseProtocol>(responseJson: JSON, fromRouter router: URLRequestConvertible, toClass: T.Type) {
    }
    
    static func getCacheData<T: VTResponseProtocol>(forRouter router: URLRequestConvertible, toClass: T.Type) -> T? {
        return nil
    }
}
