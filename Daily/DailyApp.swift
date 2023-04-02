//
//  DailyApp.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI

@main
struct DailyApp: App {

    private let mainAssembler: MainAssembler
    @ObservedObject private var viewModel: DailyAppViewModel

    init() {
        let mainAssembler = MainAssembler()

        self.mainAssembler = mainAssembler
        self.viewModel = mainAssembler.resolver.unsafeResolve(DailyAppViewModel.self)
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if viewModel.isAuthenticated {
                    RootView(resolver: mainAssembler.resolver)
                        .transition(.opacity.animation(.default))
                } else {
                    LoginView(resolver: mainAssembler.resolver)
                        .transition(.opacity.animation(.default))
                }
            }
            .environment(\.resolver, mainAssembler.resolver)
        }
    }
}
