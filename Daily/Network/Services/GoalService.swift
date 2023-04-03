//
//  GoalService.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

protocol GoalService: AnyObject {

    func getGoals() -> AnyPublisher<[DailyGoal], Error>
}

final class GoalServiceImpl {

    private let decoder = JSONDecoder()

    private let urlSession: CNURLSession

    init(urlSession: CNURLSession) {
        self.urlSession = urlSession
    }
}

extension GoalServiceImpl: GoalService {

    func getGoals() -> AnyPublisher<[DailyGoal], Error> {
        let urlRequest = URLRequest(url: .getGoals())

        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .decode(type: [DailyGoal].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

final class GoalServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(GoalService.self, initializer: GoalServiceImpl.init)
    }
}
