//
//  LoginAssemblies.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

var LoginAssemblies: [Assembly] = {
    var assemblies = [Assembly]()

    assemblies.append(LoginViewModelAssembly())

    return assemblies
}()
