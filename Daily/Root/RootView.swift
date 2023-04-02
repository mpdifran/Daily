//
//  RootView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI
import Swinject

struct RootView: View {


    init(resolver: Resolver) {

    }

    @Environment(\.resolver) var resolver: Resolver

    var body: some View {
        TabView {
            JournalView(resolver: resolver)
            AccountView(resolver: resolver)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper { (resolver) in
            RootView(resolver: resolver)
        }
    }
}
