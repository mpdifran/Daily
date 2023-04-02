//
//  UserCoordinator.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

protocol UserCoordinator: AnyObject {
    var user: AnyPublisher<User?, Never> { get }

    func login(withEmail email: String, password: String) -> AnyPublisher<Void, Error>
}

final class UserCoordinatorImpl {

    private let userSubject = CurrentValueSubject<User?, Never>(nil)

    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }
}

extension UserCoordinatorImpl: UserCoordinator {

    var user: AnyPublisher<User?, Never> {
        userSubject.eraseToAnyPublisher()
    }

    func login(withEmail email: String, password: String) -> AnyPublisher<Void, Error> {
        userService
            .login(withEmail: email, password: password)
            .receiveOnMain()
            .map { [weak self] (user) in
                self?.userSubject.send(user)
                return
            }
            .eraseToAnyPublisher()
    }
}

final class UserCoordinatorAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            UserCoordinator.self,
            initializer: UserCoordinatorImpl.init
        ).inObjectScope(.container)
    }
}
