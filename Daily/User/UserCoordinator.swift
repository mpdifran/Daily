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
}

final class UserCoordinatorImpl {

    private let userSubject = CurrentValueSubject<User?, Never>(nil)
}

extension UserCoordinatorImpl: UserCoordinator {

    var user: AnyPublisher<User?, Never> {
        userSubject.eraseToAnyPublisher()
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
