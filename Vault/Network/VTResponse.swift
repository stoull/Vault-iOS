//
//  VTResponse.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import SwiftyJSON

struct VTResponse: VTResponseProtocol, Codable {
    var jsonObject: SwiftyJSON.JSON
    
    init(json response: SwiftyJSON.JSON) {
        self.jsonObject = response
    }
}
