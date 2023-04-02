//
//  DailyGoalCell.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import SwiftUI

struct DailyGoalCell: View {
    private let dailyGoal: DailyGoal

    init(dailyGoal: DailyGoal) {
        self.dailyGoal = dailyGoal
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(dailyGoal.title)
                    .font(.title)

                Text("\(dailyGoal.createdAt, formatter: DailyGoalCell.dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer(minLength: 0)
        }
        .padding()
        .clipShape(clipShape)
        .background(backgroundView)
    }
}

private extension DailyGoalCell {

    var clipShape: some Shape {
        RoundedRectangle(cornerRadius: 15)
    }

    var backgroundView: some View {
        clipShape
            .fill(Color(uiColor: .secondarySystemGroupedBackground))
            .shadow(color: Color.gray.opacity(0.33), radius: 10)
    }
}

struct DailyGoalCell_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHelper { (_) in
            DailyGoalCell(dailyGoal: previewDailyGoal)
        }
    }
}

private let previewDailyGoal = DailyGoal(
    title: "I want to post a video on Youtube today!"
)
