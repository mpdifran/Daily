//
//  URL+Goals.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import Foundation

extension URL {

    static func getGoals() -> URL {
        URL.base.appendingPathComponent("goals")
    }

    static func createGoal(title: String) -> URL {
        var url = URL.base.appendingPathComponent("goals/create")

        url.append(queryItems: [.init(name: "title", value: title)])

        return url
    }

    static func completeGoal(id: UUID) -> URL {
        var url = URL.base.appendingPathComponent("goals/complete")

        url.append(queryItems: [.init(name: "id", value: id.uuidString)])

        return url
    }
}
