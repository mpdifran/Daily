//
//  Resolver+Unsafe.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

extension Resolver {

    /// Force unwraps the service, either providing the instance or crashing the app.
    func unsafeResolve<Service>(_ serviceType: Service.Type) -> Service {
        resolve(serviceType)!
    }
}
