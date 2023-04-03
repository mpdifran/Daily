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
    var isLoadingGoals: AnyPublisher<Bool, Never> { get }

    func createGoal(title: String) -> AnyPublisher<Void, Error>
}

final class DailyGoalCoordinatorImpl {

    private let goalsSubject = CurrentValueSubject<[DailyGoal], Never>([])
    private let isLoadingGoalsSubject = CurrentValueSubject<Bool, Never>(false)

    private var subscriptions = Set<AnyCancellable>()

    private let goalService: GoalService
    private let userCoordinator: UserCoordinator

    init(
        goalService: GoalService,
        userCoordinator: UserCoordinator
    ) {
        self.goalService = goalService
        self.userCoordinator = userCoordinator

        setupSubscriptions()
    }
}

extension DailyGoalCoordinatorImpl: DailyGoalCoordinator {

    var goals: AnyPublisher<[DailyGoal], Never> {
        goalsSubject.eraseToAnyPublisher()
    }

    var isLoadingGoals: AnyPublisher<Bool, Never> {
        isLoadingGoalsSubject.eraseToAnyPublisher()
    }

    func createGoal(title: String) -> AnyPublisher<Void, Error> {
        goalService
            .createGoal(title: title)
            .receiveOnMain()
            .map { [goalsSubject] (goal) in
                var existingGoals = goalsSubject.value
                existingGoals.insert(goal, at: 0)
                goalsSubject.send(existingGoals)

                // TODO: Update notification handler
                return
            }
            .eraseToAnyPublisher()
    }
}

private extension DailyGoalCoordinatorImpl {

    func setupSubscriptions() {
        userCoordinator
            .user
            .map { [weak self] (user) in
                if user != nil {
                    self?.fetchGoals()
                } else {
                    self?.clearGoals()
                }
            }
            .sinkAndStore(in: &subscriptions)
    }

    func fetchGoals() {
        isLoadingGoalsSubject.send(true)
        goalService
            .getGoals()
            .receiveOnMain()
            .map { [weak self] (goals) in
                self?.goalsSubject.send(goals)
                return
            }
            .receiveCompletion(andStoreIn: &subscriptions) { [weak self] (_) in
                self?.isLoadingGoalsSubject.send(false)
            }
    }

    func clearGoals() {
        goalsSubject.send([])
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
