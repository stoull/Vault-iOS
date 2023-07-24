//
//  VTRequestInterceptor.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import Alamofire

final class VTRequestInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 10
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
      let urlRequest = urlRequest
//      if let token = TokenManager.shared.fetchAccessToken() {
//        urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
//      }
      completion(.success(urlRequest))
    }

    // 重试
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//      let response = request.task?.response as? HTTPURLResponse
//      //Retry for 5xx status codes
//      if let statusCode = response?.statusCode,
//        (500...599).contains(statusCode),
//        request.retryCount < retryLimit {
//          completion(.retryWithDelay(retryDelay))
//      } else {
//        return completion(.doNotRetry)
//      }
//    }
}
