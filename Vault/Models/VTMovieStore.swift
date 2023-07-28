//
//  VTMovieStore.swift
//  Vault
//
//  Created by Kevin on 2023/7/27.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct VTAPIMovieResponse: Codable {
    var result: Int = 0
    var message: String?
    var movies: [VTMovie]?
}

class VTMovieStore {
    public static let shared = VTMovieStore()
    
    func getUrl(keywords: String) throws -> URL {
        let root = VTHostManager.host(with: .internet)
        let path = "/api/v1/movies/search"

        guard var components = URLComponents(string: root) else {
            throw VTAPIError.urlError(URLError(.unsupportedURL))
        }
        components.path = path
        var queryItems:[URLQueryItem] = components.queryItems ?? []
        let keywordsItem = URLQueryItem(name: "keywords", value: keywords)
        queryItems.append(keywordsItem)
        
        components.queryItems = queryItems
        
        guard let rUrl = components.url else {
            throw VTAPIError.urlError(URLError(.unsupportedURL))
        }
        return rUrl
    }
    
    func searchMovies(keywords: String) -> AnyPublisher<[VTMovie], VTAPIError> {
        
        guard let url = try? getUrl(keywords: keywords) else {
            let subject = PassthroughSubject<[VTMovie], VTAPIError>()
            subject.send(completion: .failure(.urlError(URLError(.unsupportedURL))))
            return subject.eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw VTAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                }
                return data
            }
            .decode(type: [VTMovie].self, decoder: JSONDecoder())
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
    
    func loadImage(urlString: String) -> AnyPublisher<Image, VTAPIError> {
        guard let url = URL(string: urlString) else {
            let subject = PassthroughSubject<Image, VTAPIError>()
            subject.send(completion: .failure(.urlError(URLError(.unsupportedURL))))
            return subject.eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Image in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw VTAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                }
                return VTTools.createImage(data)
            }
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
