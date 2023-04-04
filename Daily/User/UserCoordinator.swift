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
    func logout()
}

final class UserCoordinatorImpl {

    private let userSubject = CurrentValueSubject<User?, Never>(nil)
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService

        loadUser()
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
                self?.store(user)
                return
            }
            .eraseToAnyPublisher()
    }

    func logout() {
        userSubject.send(nil)
        store(nil)
    }
}

private extension UserCoordinatorImpl {

    func store(_ user: User?) {
        guard let user = user else {
            defaults.removeObject(forKey: "Daily.user")
            return
        }
        do {
            let data = try encoder.encode(user)
            defaults.set(data, forKey: "Daily.user")
        } catch {
            print(error)
        }
    }

    func loadUser() {
        do {
            guard let data = defaults.data(forKey: "Daily.user") else { return }

            let user = try decoder.decode(User.self, from: data)
            userSubject.send(user)
        } catch {
            print(error)
        }
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
