//
//  VTResponseProtocol.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol VTResponseProtocol {
    /// 整个服务器响应，包含code和data [String: Any]
    var jsonObject: JSON { get }
    
    /// 服务器响应码 1为成功，0为失败
    var code: Int { get }
    /// 服务器响应码为0时的返回的提示语
    var message: String { get }
    
    /// 服务端返回的状态码
    var status: VTResponseCode { get }
    
    /// 对应“data”或“obj”的内容,真实存储数据段
    var data: JSON? { get }

    init(json response: JSON)
}

extension VTResponseProtocol {
    var code: Int {
        return jsonObject["code"].intValue
    }
    
    var message: String {
        return jsonObject["message"].stringValue
    }
    
    var data: JSON? {
        return jsonObject["data"]
    }
    
    var status: VTResponseCode {
        return VTResponseCode(rawValue: code) ?? .unknow
    }
}
