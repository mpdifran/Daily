//
//  JournalView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI
import Swinject

struct JournalView: View {

    init(resolver: Resolver) {

    }

    var body: some View {
        NavigationView {
            List {
                Text("First goal")
                Text("Second goal")
            }
            .navigationTitle("Journal")
        }
        .tabItem {
            Label("Journal", systemImage: "text.book.closed")
        }
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper { (resolver) in
            TabView {
                JournalView(resolver: resolver)
            }
        }
    }
}
