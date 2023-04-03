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
            contentView
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

private extension JournalView {

    @ViewBuilder
    var contentView: some View {
        if viewModel.isLoadingGoals {
            loadingContentView
        } else if viewModel.goals.isEmpty {
            emptyContentView
        } else {
            loadedContentView
        }
    }

    var loadingContentView: some View {
        ProgressView()
    }

    var emptyContentView: some View {
        Group {
            Text("No Goals Yet")
            Text("Create one now!")
                .font(.caption)
        }
        .foregroundColor(.secondary)
    }

    var loadedContentView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.goals) { (goal) in
                    DailyGoalCell(dailyGoal: goal)
                        .padding()
                }
            }
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
