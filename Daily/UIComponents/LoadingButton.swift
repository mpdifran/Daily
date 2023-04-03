//
//  LoadingButton.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import SwiftUI

struct LoadingButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    Text(title)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
        })
        .buttonStyle(.borderedProminent)
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoadingButton(title: "Log In", isLoading: false) { }
            LoadingButton(title: "Create", isLoading: true) { }
        }
        .padding()
    }
}
