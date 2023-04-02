//
//  AccountView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI
import Swinject

struct AccountView: View {

    @ObservedObject private var viewModel: AccountViewModel

    init(resolver: Resolver) {
        self.viewModel = resolver.unsafeResolve(AccountViewModel.self)
    }

    var body: some View {
        NavigationView {
            List {
                if let email = viewModel.email {
                    Section("Details") {
                        AccountCell(systemImageName: "at", title: "Email", value: email)
                    }
                }

                Section {
                    Button("Logout") {
                        viewModel.logout()
                    }
                }
            }
            .navigationTitle("Account")
        }
        .tabItem {
            Label("Account", systemImage: "person")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper { (resolver) in
            AccountView(resolver: resolver)
        }
    }
}
