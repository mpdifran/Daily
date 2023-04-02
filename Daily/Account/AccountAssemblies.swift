//
//  AccountAssemblies.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

var AccountAssemblies: [Assembly] = {
    var assemblies = [Assembly]()

    assemblies.append(AccountViewModelAssembly())

    return assemblies
}()
