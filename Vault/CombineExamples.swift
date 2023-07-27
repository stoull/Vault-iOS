//
//  CombineExamples.swift
//  Vault
//
//  Created by Kevin on 2023/7/20.
//

import Foundation
import SwiftUI
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

// https://www.infoq.cn/article/eaq01u5jevuvqfghlqbs
// https://github.com/Kilo-Loco/content/tree/main/apple/swiftui-life-cycle
// https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine
// https://github.com/shankarmadeshvaran/Movie_Trailers_SwiftUI
