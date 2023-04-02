//
//  AccountCell.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI

struct AccountCell: View {
    let systemImageName: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .foregroundColor(.accentColor)

            Text(title)

            Spacer()

            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct SettingCell_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper { (_) in
            List {
                AccountCell(systemImageName: "at", title: "Email", value: "mark@creatornow.com")
            }
        }
    }
}
