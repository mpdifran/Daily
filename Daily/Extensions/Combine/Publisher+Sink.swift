//
//  Publisher+Sink.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine

extension Publisher {

    func receiveCompletion(andStoreIn set: inout Set<AnyCancellable>, receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void)) {
        sink { (completion) in
            receiveCompletion(completion)
        } receiveValue: { _ in

        }
        .store(in: &set)
    }

    func handleErrorAndStore(in set: inout Set<AnyCancellable>, errorHandler: @escaping (Error) -> Void) {
        sink { (completion) in
            switch completion {
            case .failure(let error):
                errorHandler(error)
            case .finished:
                break
            }
        } receiveValue: { _ in

        }
        .store(in: &set)
    }

    func sinkAndStore(in set: inout Set<AnyCancellable>) {
        sink { (_) in

        } receiveValue: { (_) in

        }
        .store(in: &set)
    }
}
