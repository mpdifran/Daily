//
//  CreateGoalView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import SwiftUI
import Swinject
import Combine

struct CreateGoalView: View {

    @ObservedObject private var viewModel: CreateGoalViewModel

    init(resolver: Resolver) {
        self.viewModel = resolver.unsafeResolve(CreateGoalViewModel.self)
    }

    @State private var goalText = ""
    @State private var isLoading = false
    @State private var error: Error?
    @State private var subscriptions = Set<AnyCancellable>()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()

                TextField("What's your Goal?", text: $goalText)
                    .font(.title)
                    .textFieldStyle(.roundedBorder)

                Spacer()

                LoadingButton(title: "Create", isLoading: isLoading) {
                    createGoal()
                }
            }
            .padding()
            .navigationTitle("Create Daily Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(isLoading)
                }
            }
        }
        .alert(error: $error)
    }
}

private extension CreateGoalView {

    func createGoal() {
        guard !goalText.isEmpty else {
            let error = NSError("Looks like you forgot to make a goal!")
            self.error = error
            return
        }

        isLoading = true
        viewModel
            .createGoal(title: goalText)
            .sink(receiveCompletion: { (completion) in
                self.isLoading = false
                self.presentationMode.wrappedValue.dismiss()
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            }, receiveValue: { (_) in })
            .store(in: &subscriptions)
    }
}

struct CreateGoalView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper { (resolver) in
            CreateGoalView(resolver: resolver)
        }
    }
}
