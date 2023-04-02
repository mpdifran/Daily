//
//  DailyApp.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI

@main
struct DailyApp: App {

    let mainAssembler = MainAssembler()

    var body: some Scene {
        WindowGroup {
            RootView(resolver: mainAssembler.resolver)
                .environment(\.resolver, mainAssembler.resolver)
        }
    }
}
