//
//  NetworkAssemblies.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

var NetworkAssemblies: [Assembly] = {
    var assemblies = [Assembly]()

    assemblies.append(CNURLSessionMockAssembly())
    assemblies.append(UserServiceAssembly())
    assemblies.append(GoalServiceAssembly())

    return assemblies
}()
