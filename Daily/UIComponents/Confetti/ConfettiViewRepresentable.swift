//
//  ConfettiViewRepresentable.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import SwiftUI

struct ConfettiViewRepresentable: UIViewRepresentable {

    @Binding var isEmitting: Bool

    func makeUIView(context: Context) -> ConfettiView {
        ConfettiView()
    }

    func updateUIView(_ uiView: ConfettiView, context: Context) {
        guard isEmitting else { return }

        uiView.emit()
        isEmitting = false
    }
}
