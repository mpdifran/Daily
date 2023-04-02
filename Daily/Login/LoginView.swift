//
//  LoginView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI
import Swinject
import Combine

struct LoginView: View {

    @ObservedObject private var viewModel: LoginViewModel

    init(resolver: Resolver) {
        self.viewModel = resolver.unsafeResolve(LoginViewModel.self)
    }

    @State private var error: Error?
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false

    @FocusState private var focusedField: Field?

    @State private var subscriptions = Set<AnyCancellable>()

    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section {
                    TextField("Email", text: $email) {
                        focusedField = .password
                    }
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)

                    SecureField("Password", text: $password) {
                        login()
                    }
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                } header: {
                    headerView
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
            }

            Button {
                guard !isLoggingIn else { return }

                login()
            } label: {
                Group {
                    if isLoggingIn {
                        ProgressView()
                    } else {
                        Text("Log In")
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .background(ignoresSafeAreaEdges: .all)
        .alert(error: $error)
    }
}

private extension LoginView {

    @ViewBuilder
    var headerView: some View {
        HStack {
            Spacer()
            Image("DailyIcon")
                .resizable()
                .frame(width: 250, height: 250)
            Spacer()
        }
        Text("Daily")
            .font(.title)
    }
}

private extension LoginView {

    func login() {
        isLoggingIn = true
        viewModel
            .login(withEmail: email, password: password)
            .receiveCompletion(andStoreIn: &subscriptions) { (completion) in
                self.isLoggingIn = false
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            }
    }
}

extension LoginView {
    enum Field: Hashable {
        case email, password
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper { (resolver) in
            LoginView(resolver: resolver)
        }
    }
}
