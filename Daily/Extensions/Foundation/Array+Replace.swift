//
//  Array+Replace.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import Foundation

extension Array where Element: Identifiable {

    @discardableResult
    mutating func replace(_ element: Element) -> Bool {
        guard let index = firstIndex(where: { $0.id == element.id }) else {
            return false
        }

        self.remove(at: index)
        self.insert(element, at: index)
        return true
    }
}
