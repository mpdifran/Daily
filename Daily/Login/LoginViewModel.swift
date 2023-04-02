//
//  LoginViewModel.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class LoginViewModel: ObservableObject {

}

extension LoginViewModel {

    func login() {
        print("Attempting to log in")
    }
}

final class LoginViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(LoginViewModel.self, initializer: LoginViewModel.init)
    }
}
