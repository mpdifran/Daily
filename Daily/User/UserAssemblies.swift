//
//  UserAssemblies.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

var UserAssemblies: [Assembly] = {
    var assemblies = [Assembly]()

    assemblies.append(UserCoordinatorAssembly())

    return assemblies
}()
