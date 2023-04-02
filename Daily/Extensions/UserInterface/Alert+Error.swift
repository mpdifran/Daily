//
//  Alert+Error.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI

extension Alert {

    init(error: Error?, onDismiss: @escaping () -> Void = { }) {
        self.init(title: Text("Whoops!"),
                  message: Text(error?.localizedDescription ?? ""),
                  dismissButton: .default(Text("OK"), action: onDismiss))
    }
}
