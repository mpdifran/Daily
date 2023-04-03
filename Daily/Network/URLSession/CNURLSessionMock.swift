//
//  CNURLSessionMock.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine
import Swinject
import SwinjectAutoregistration

final class CNURLSessionMock {

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "CNURLSessionMock")
    private let defaults = UserDefaults.standard

    private var cachedGoals = [DailyGoal]() {
        didSet { storeCachedGoals() }
    }

    init() {
        cachedGoals = decodeCachedGoals()
    }
}

extension CNURLSessionMock: CNURLSession {

    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<Data, Error> {
        switch request.url?.path() {
        case "/login":
            return mockPublisherForLogin(urlRequest: request)
        case "/goals":
            return mockPublisherForGoals()
        default:
            break
        }

        let error = NSError("Unknown Endpoint")
        return Fail(error: error).eraseToAnyPublisher()
    }
}

private extension CNURLSessionMock {

    func mockPublisherForLogin(urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)

        let queryItems = urlComponents?.queryItems ?? []

        guard let email = queryItems.first(where: { $0.name == "email" })?.value,
              let password = queryItems.first(where: { $0.name == "password" })?.value else {
            let error = NSError("Invalid request.")
            return Fail(error: error).eraseToAnyPublisher()
        }

        guard email == "mark@creatornow.com", password == "password" else {
            let error = NSError("Invalid credentials. Please try again.")
            return Fail(error: error).eraseToAnyPublisher()
        }

        do {
            let user = User(email: email, password: password)
            let data = try encoder.encode(user)

            return Just(data)
                .setFailureType(to: Error.self)
                .receive(on: queue)
                .delay(for: 1, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            let error = NSError("5xx Server Error")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    func mockPublisherForGoals() -> AnyPublisher<Data, Error> {
        do {
            let data = try encoder.encode(cachedGoals)

            return Just(data)
                .setFailureType(to: Error.self)
                .receive(on: queue)
                .delay(for: 1, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            let error = NSError("5xx Server Error")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

private extension CNURLSessionMock {

    func decodeCachedGoals() -> [DailyGoal] {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .init(day: -1), to: today)!
        let dayBeforeYesterday = Calendar.current.date(byAdding: .init(day: -2), to: today)!

        let firstTask = DailyGoal(title: "Post a YouTube Short", createdAt: yesterday)
        let secondTask = DailyGoal(title: "Engage with audience", createdAt: dayBeforeYesterday)

        let defaultGoals = [firstTask, secondTask]

        guard let data = defaults.data(forKey: "Daily.goals") else {
            return defaultGoals
        }

        do {
            return try decoder.decode([DailyGoal].self, from: data)
        } catch {
            print(error)
            return defaultGoals
        }
    }

    func storeCachedGoals() {
        do {
            let data = try encoder.encode(cachedGoals)
            defaults.set(data, forKey: "Daily.goals")
        } catch {
            print(error)
        }
    }
}

final class CNURLSessionMockAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            CNURLSession.self,
            initializer: CNURLSessionMock.init
        ).inObjectScope(.weak)
    }
}
