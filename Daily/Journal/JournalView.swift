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

    @State private var showCreateGoalView = false
    @State private var isEmitting = false

    @Environment(\.resolver) private var resolver

    var body: some View {
        NavigationView {
            contentView
            .animation(.default, value: viewModel.goals)
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showCreateGoalView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .tabItem {
            Label("Journal", systemImage: "text.book.closed")
        }
        .sheet(isPresented: $showCreateGoalView) {
            CreateGoalView(resolver: resolver)
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
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.goals) { (goal) in
                        DailyGoalCell(dailyGoal: goal) {
                            viewModel.completeGoal(goal: goal)
                            isEmitting = true
                        }
                        .padding()
                    }
                }
            }

            ConfettiViewRepresentable(isEmitting: $isEmitting)
                .frame(height: 1)
                .zStackAlignment(.top)
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
