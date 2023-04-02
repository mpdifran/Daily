//
//  DailyGoalCoordinator.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

protocol DailyGoalCoordinator: AnyObject {
    var goals: AnyPublisher<[DailyGoal], Never> { get }

    func createGoal(title: String)
}

final class DailyGoalCoordinatorImpl {

    private let goalsSubject = CurrentValueSubject<[DailyGoal], Never>([])
}

extension DailyGoalCoordinatorImpl: DailyGoalCoordinator {

    var goals: AnyPublisher<[DailyGoal], Never> {
        goalsSubject.eraseToAnyPublisher()
    }

    func createGoal(title: String) {
        let goal = DailyGoal(title: title)

        // TODO: Update notification handler

        var existingGoals = goalsSubject.value
        existingGoals.append(goal)
        goalsSubject.send(existingGoals)
    }
}

final class DailyGoalCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
            DailyGoalCoordinator.self,
            initializer: DailyGoalCoordinatorImpl.init
        ).inObjectScope(.container)
    }
}
