//
//  JournalView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI
import Swinject

struct JournalView: View {

    @ObservedObject private var viewModel: JournalViewModel

    init(resolver: Resolver) {
        self.viewModel = resolver.unsafeResolve(JournalViewModel.self)
    }

    var body: some View {
        NavigationView {
            List(viewModel.goals) { (goal) in
                Text(goal.title)
            }
            .animation(.default, value: viewModel.goals)
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // Create fake goals for now.
                        viewModel.createGoal(title: "Test \(viewModel.goals.count)")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
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
