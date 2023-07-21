//
//  CombineExamples.swift
//  Vault
//
//  Created by Kevin on 2023/7/20.
//

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

/// Subscribers
func testCombineSubscription() {
    let myList = [1,2,3,4,5,6]
    let myListPublisher = Publishers.Sequence<[Int], Never>(sequence: myList)
    
    let subcriber = Subscribers.Sink<Int,Never> { completion in
        print("subscriber completion: \(completion) ")
    } receiveValue: { result in
        print("recevieValue:\(result)")
    }
    myListPublisher.subscribe(subcriber)
//
//        let subscriber2 = myListPublisher.sink { completion in
//            print("subscriber2 completion: \(completion) ")
//        } receiveValue: { result in
//            print("recevieValue2:\(result)")
//        }
////
//        let subscriber3 = [1,2,3,4,5,6].publisher.sink { completion in
//            print("subscriber3 completion: \(completion) ")
//        } receiveValue: { result in
//            print("recevieValue3:\(result)")
//        }
}

/// Subject
func testCombineSubject() {
    enum ExampleError: Swift.Error {
        case somethingWentWrong
    }
    let subject = PassthroughSubject<String, ExampleError>()
    subject.sink { (completion) in
        print("Subscriber completion: \(completion)")
    } receiveValue: { value in
        print("Subscriber received value: \(value)")
    }
    .store(in: &subscriptions) // 异步的订阅需要保存, 保证订阅者不会被释放
    
    subject.send("Hello")
    subject.send("Hello Again!")
    subject.send(completion: .failure(.somethingWentWrong))
    subject.send("Hello Again Again!")
    subject.send(completion: .finished) // 此时事件流已经结束，所以输出结果中不会再有后续的 send 的 Value。

}


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

struct VTAPIMovieResponse: Codable {
    var result: Int = 0
    var message: String?
    var movies: [VTMovie]?
}

class VTMovieStore {
    public static let shared = VTMovieStore()
    
    func getUrl(keywords: String) -> String {
        return "http://192.168.1.200:5000/api/v1/movies/search?keywords=\(keywords)"
    }
    
    func searchMovies(keywords: String) -> AnyPublisher<[VTMovie], VTAPIError> {
        guard let url = URL(string: self.getUrl(keywords: keywords)) else {
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
    
    func loadImage(urlString: String) -> AnyPublisher<Data, VTAPIError> {
        guard let url = URL(string: urlString) else {
            let subject = PassthroughSubject<Data, VTAPIError>()
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

// https://www.infoq.cn/article/eaq01u5jevuvqfghlqbs
// https://github.com/Kilo-Loco/content/tree/main/apple/swiftui-life-cycle
// https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine
// https://github.com/shankarmadeshvaran/Movie_Trailers_SwiftUI
