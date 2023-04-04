//
//  NotificationAssemblies.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import Foundation
import Swinject

var NotificationAssemblies: [Assembly] = {
    var assemblies = [Assembly]()

    assemblies.append(NotificationCoordinatorAssembly())

    return assemblies
}()
