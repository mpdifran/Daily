//
//  JournalAssemblies.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

var JournalAssemblies: [Assembly] = {
    var assemblies = [Assembly]()

    assemblies.append(JournalViewModelAssembly())

    return assemblies
}()
