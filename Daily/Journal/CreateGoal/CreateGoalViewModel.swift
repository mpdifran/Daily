//
//  CreateGoalViewModel.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

final class CreateGoalViewModel: ObservableObject {
    @Published var isLoading = false

    private var subscriptions = Set<AnyCancellable>()

    private let goalCoordinator: DailyGoalCoordinator

    init(goalCoordinator: DailyGoalCoordinator) {
        self.goalCoordinator = goalCoordinator
    }
}

extension CreateGoalViewModel {

    func createGoal(title: String) -> AnyPublisher<Void, Error> {
        goalCoordinator
            .createGoal(title: title)
            .eraseToAnyPublisher()
    }
}

final class CreateGoalViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(CreateGoalViewModel.self, initializer: CreateGoalViewModel.init)
    }
}
