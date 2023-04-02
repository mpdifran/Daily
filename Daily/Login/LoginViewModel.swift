//
//  LoginViewModel.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import Combine

final class LoginViewModel: ObservableObject {

    private var subscriptions = Set<AnyCancellable>()

    private let userCoordinator: UserCoordinator

    init(userCoordinator: UserCoordinator) {
        self.userCoordinator = userCoordinator
    }
}

extension LoginViewModel {

    func login(withEmail email: String, password: String) -> AnyPublisher<Void, Error> {
        userCoordinator
            .login(withEmail: email, password: password)
            .eraseToAnyPublisher()
    }
}

final class LoginViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(LoginViewModel.self, initializer: LoginViewModel.init)
    }
}
