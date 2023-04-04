//
//  JournalViewModel.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

final class JournalViewModel: ObservableObject {
    @Published var goals = [DailyGoal]()
    @Published var isLoadingGoals = false

    private var subscriptions = Set<AnyCancellable>()

    private let dailyGoalCoordinator: DailyGoalCoordinator

    init(dailyGoalCoordinator: DailyGoalCoordinator) {
        self.dailyGoalCoordinator = dailyGoalCoordinator

        setupSubscriptions()
    }
}

extension JournalViewModel {

    func completeGoal(goal: DailyGoal) {
        dailyGoalCoordinator
            .completeGoal(goal: goal)
    }
}

private extension JournalViewModel {

    func setupSubscriptions() {
        dailyGoalCoordinator
            .goals
            .sink { [weak self] (goals) in
                self?.goals = goals
            }
            .store(in: &subscriptions)

        dailyGoalCoordinator
            .isLoadingGoals
            .sink { [weak self] (isLoadingGoals) in
                self?.isLoadingGoals = isLoadingGoals
            }
            .store(in: &subscriptions)
    }
}

final class JournalViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(JournalViewModel.self, initializer: JournalViewModel.init)
    }
}
