//
//  MainAssembler.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject

final class MainAssembler {
    var resolver: Resolver {
        return assembler.resolver
    }
    let assembler = Assembler()

    init() {
        assembler.apply(assemblies: NetworkAssemblies)
    }
}