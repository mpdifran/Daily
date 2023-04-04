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
    private let dailyGoalCoordinator: DailyGoalCoordinator
    private let notificationCoordinator: NotificationCoordinator

    init(
        userCoordinator: UserCoordinator,
        dailyGoalCoordinator: DailyGoalCoordinator,
        notificationCoordinator: NotificationCoordinator
    ) {
        self.userCoordinator = userCoordinator
        self.dailyGoalCoordinator = dailyGoalCoordinator
        self.notificationCoordinator = notificationCoordinator

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
                if !isAuthenticated {
                    self?.notificationCoordinator.clearNotifications()
                }
            }
            .store(in: &subscriptions)
    }
}

final class DailyAppViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(DailyAppViewModel.self, initializer: DailyAppViewModel.init)
    }
}
