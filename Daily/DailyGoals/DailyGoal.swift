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
    let createdAt: Date

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = Date()
    }

    /// Initializer to be used by the mock backend to help create tasks with dates in the past.
    init(title: String, createdAt: Date) {
        self.id = UUID()
        self.title = title
        self.createdAt = createdAt
    }
}
