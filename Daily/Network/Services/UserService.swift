//
//  UserService.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

protocol UserService {
    func login(withEmail email: String, password: String) -> AnyPublisher<User, Error>
}

final class UserServiceImpl {

    private let decoder = JSONDecoder()

    private let urlSession: CNURLSession

    init(urlSession: CNURLSession) {
        self.urlSession = urlSession
    }
}

extension UserServiceImpl: UserService {

    func login(withEmail email: String, password: String) -> AnyPublisher<User, Error> {
        let urlRequest = URLRequest(url: .login(email: email, password: password))

        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .decode(type: User.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

final class UserServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(UserService.self, initializer: UserServiceImpl.init)
    }
}
