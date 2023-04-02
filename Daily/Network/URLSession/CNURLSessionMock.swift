//
//  CNURLSessionMock.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

final class CNURLSessionMock {

}

extension CNURLSessionMock: CNURLSession {

    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<Data, Error> {
        let error = NSError("Unknown Endpoint")

        return Fail(error: error).eraseToAnyPublisher()
    }
}

final class CNURLSessionMockAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            CNURLSession.self,
            initializer: CNURLSessionMock.init
        ).inObjectScope(.weak)
    }
}
