//
//  ResolverEnvironmentKey.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import SwiftUI
import Swinject

private struct ResovlerEnvironmentKey: EnvironmentKey {
    static let defaultValue: Resolver = Container()
}

extension EnvironmentValues {
    var resolver: Resolver {
        get { self[ResovlerEnvironmentKey.self] }
        set { self[ResovlerEnvironmentKey.self] = newValue }
    }
}
