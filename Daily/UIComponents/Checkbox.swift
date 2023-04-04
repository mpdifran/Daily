//
//  Checkbox.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import SwiftUI

struct Checkbox: View {
    let isChecked: Bool

    var body: some View {
        Group {
            if isChecked {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
        }
        .font(.title)
        .foregroundColor(.accentColor)
    }
}

struct CheckboxButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Checkbox(isChecked: true)
            Checkbox(isChecked: false)
        }
    }
}
