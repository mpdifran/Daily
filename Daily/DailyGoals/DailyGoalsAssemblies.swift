//
//  DailyGoalsAssemblies.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

var DailyGoalsAssemblies: [Assembly] = {
    var assemblies = [Assembly]()

    assemblies.append(DailyGoalCoordinatorAssembly())

    return assemblies
}()
