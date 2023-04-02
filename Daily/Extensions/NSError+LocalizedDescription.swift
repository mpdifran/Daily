//
//  NSError+LocalizedDescription.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation

extension NSError {

    convenience init(_ description: String) {
        self.init(domain: "com.Daily.error", code: 0, userInfo: [NSLocalizedDescriptionKey : description])
    }
}
