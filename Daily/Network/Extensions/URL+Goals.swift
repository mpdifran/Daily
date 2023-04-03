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
}
