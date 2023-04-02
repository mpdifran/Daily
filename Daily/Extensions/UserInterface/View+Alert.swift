//
//  View+Alert.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI

extension View {

    func alert(error: Binding<Error?>,
               onDismiss: @escaping () -> Void = { }) -> some View {
        return alert(isPresented: Binding(isNotNil: error)) {
            Alert(error: error.wrappedValue, onDismiss: onDismiss)
        }
    }
}
