//
//  VTAPIError.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//

import Foundation

/// Operators
enum VTAPIError: Error, LocalizedError {
    case urlError(URLError)
    case responseError(Int)
    case decodingError(DecodingError)
    case genericError
    
    var localizedDescribiption: String {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .responseError(let status):
            return "Bad response code: \(status)"
        case .genericError:
            return "An unknown error has been occured"
        }
    }
}
