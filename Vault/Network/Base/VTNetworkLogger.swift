//
//  VTNetworkLogger.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class VTNetworkLogger: EventMonitor {
    func requestDidFinish(_ request: Request) {
        debugPrint("VTNetworkLogger requestDidFinish: \(request.description)")
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            if json.type == .array {
                debugPrint("NetwrokLogger: \(String(describing: json.arrayObject))")
            } else if json.type == .dictionary {
                debugPrint("NetwrokLogger: \(String(describing: json.dictionaryObject))")
            } else {
                debugPrint("NetwrokLogger: \(json.rawValue)")
            }
            
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
}

