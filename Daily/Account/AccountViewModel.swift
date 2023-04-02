//
//  AccountViewModel.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

final class AccountViewModel: ObservableObject {

    @Published var email: String?

    private var subscriptions = Set<AnyCancellable>()

    private let userCoordinator: UserCoordinator

    init(userCoordinator: UserCoordinator) {
        self.userCoordinator = userCoordinator

        setupSubscriptions()
    }
}

extension AccountViewModel {

    func setupSubscriptions() {
        userCoordinator
            .user
            .map { [weak self] (user) in
                self?.email = user?.email
            }
            .sinkAndStore(in: &subscriptions)
    }

    func logout() {
        userCoordinator.logout()
    }
}

final class AccountViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(AccountViewModel.self, initializer: AccountViewModel.init)
    }
}
