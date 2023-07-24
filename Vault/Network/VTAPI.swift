//
//  VTAPI.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import Alamofire
import Combine

final class VTAPI: SessionDelegate {
    static let shared = VTAPI()
    var reachability = try? VTReachability()
    
    
    private func fetch<T: Decodable>(_ urlRequest: URLRequestConvertible) -> AnyPublisher<T, AFError> {
        AF.request(urlRequest)
            .validate()
            .publishDecodable(type: VTResponse.self, decoder: JSONDecoder())
            .value()
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
            .tryMap { vtRes -> Data in
                return vtRes.data?.rawData() ?? Data()
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> VTAPIError in
                switch error {
                case let urlError as URLError:
                    return VTAPIError.urlError(urlError)
                case let decodingError as DecodingError:
                    return VTAPIError.decodingError(decodingError)
                case let apiError as VTAPIError:
                    return apiError
                default:
                    return VTAPIError.genericError
                }
            }
            .eraseToAnyPublisher()
    }
}
