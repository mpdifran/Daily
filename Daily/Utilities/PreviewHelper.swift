//
//  PreviewHelper.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI
import Swinject

struct PreviewHelper<Content>: View where Content: View {

    let mainAssembler = MainAssembler()
    let content: Content

    init(contentBuilder: (Resolver) -> Content) {
        self.content = contentBuilder(mainAssembler.resolver)
    }

    var body: some View {
        content
            .environment(\.resolver, mainAssembler.resolver)
    }
}
