//
//  VTRouter.swift
//  Vault
//
//  Created by Kevin on 2023/7/24.
//  Copyright © 2023 Hut. All rights reserved.
//

import Foundation
import UIKit
import Combine

class VTImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private var cache: VTImageCache?
    private var cancelable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    convenience init(urlString: String, cache: VTImageCache? = nil) throws {
        guard let rUrl = URL(string: urlString) else {
            throw VTAPIError.urlError(URLError(.unsupportedURL))
        }
        self.init(url: rUrl, cache: cache)
    }
    
    init(url: URL, cache: VTImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else {return}
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        debugPrint("xxxxx url: \(url.absoluteString)")
        
        cancelable = fetch(url: url)
            .sink { completion in
                print("加载图片 completion: \(completion)")
            } receiveValue: { img in
                print("loadImage 成功！")
                self.image = img
            }
    }
    
    func cancel() {
        cancelable?.cancel()
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinished() {
        isLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map{ cache?[url] = $0 }
    }
    
    private func fetch(url: URL) -> AnyPublisher<UIImage?, VTAPIError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> UIImage? in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw VTAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                }
                return UIImage(data: data)
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
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinished() },
                          receiveCancel: { [weak self] in self?.onFinished() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
