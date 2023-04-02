//
//  LoginView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI
import Swinject

struct LoginView: View {

    @ObservedObject private var viewModel: LoginViewModel

    init(resolver: Resolver) {
        self.viewModel = resolver.unsafeResolve(LoginViewModel.self)
    }

    @Environment(\.resolver) var resolver: Resolver

    @State private var email = ""
    @State private var password = ""

    @FocusState private var focusedField: Field?

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
                        viewModel.login()
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
                viewModel.login()
            } label: {
                Text("Log In")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .background(ignoresSafeAreaEdges: .all)
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
