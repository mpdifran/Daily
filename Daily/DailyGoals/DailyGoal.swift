//
//  DailyGoal.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation

struct DailyGoal: Codable, Identifiable, Equatable {

    let id: UUID
    let title: String
    let isComplete: Bool
    let createdAt: Date

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isComplete = false
        self.createdAt = Date()
    }

    /// Initializer to be used by the mock backend to help create tasks with dates in the past.
    internal init(
        id: UUID,
        title: String,
        isComplete: Bool,
        createdAt: Date
    ) {
        self.id = id
        self.title = title
        self.isComplete = isComplete
        self.createdAt = createdAt
    }
}

extension DailyGoal {

    func complete() -> DailyGoal {
        .init(
            id: id,
            title: title,
            isComplete: true,
            createdAt: createdAt
        )
    }
}
