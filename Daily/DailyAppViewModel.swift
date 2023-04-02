//
//  DailyAppViewModel.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

final class DailyAppViewModel: ObservableObject {

    @Published var isAuthenticated = false

    private var subscriptions = Set<AnyCancellable>()

    private let userCoordinator: UserCoordinator

    init(userCoordinator: UserCoordinator) {
        self.userCoordinator = userCoordinator

        setupSubscriptions()
    }
}

private extension DailyAppViewModel {

    func setupSubscriptions() {
        userCoordinator
            .user
            .map { $0 != nil }
            .sink { [weak self] (isAuthenticated) in
                self?.isAuthenticated = isAuthenticated
            }
            .store(in: &subscriptions)
    }
}

final class DailyAppViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(DailyAppViewModel.self, initializer: DailyAppViewModel.init)
    }
}
