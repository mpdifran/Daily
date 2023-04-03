//
//  URL+User.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation

extension URL {
    static func login(email: String, password: String) -> URL {
        var url = URL.base.appendingPathComponent("login")

        url.append(queryItems: [
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: password)
        ])

        return url
    }
}
