//
//  NotificationCoordinator.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import Foundation
import UserNotifications
import Swinject
import SwinjectAutoregistration

protocol NotificationCoordinator: AnyObject {

    func requestAuthorization()
    func scheduleNotification(forLastGoalDate lastGoalDate: Date)
    func clearDeliveredNotifications()
    func clearNotifications()
}

final class NotificationCoordinatorImpl {

}

extension NotificationCoordinatorImpl: NotificationCoordinator {

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (success, error) in
            if let error = error {
                print(error)
            }
        }
    }

    func clearDeliveredNotifications() {
        print("Clearing delivered notifications")
        UNUserNotificationCenter.current()
            .removeDeliveredNotifications(withIdentifiers: [.reminderNotificationIdentifier])
    }

    func clearNotifications() {
        print("Clearing pending notifications")
        UNUserNotificationCenter.current()
            .removeAllPendingNotificationRequests()
    }

    func scheduleNotification(forLastGoalDate lastGoalDate: Date) {
        clearNotifications()

        print("Scheduling notification for \(lastGoalDate)")

        let content = UNMutableNotificationContent()
        content.title = "Daily Goal Reminder"
        content.body = "Don't forget to set your goal for today!"
        content.sound = .default
        content.interruptionLevel = .timeSensitive

        let triggerDate = Calendar.current.nextDate(
            after: lastGoalDate,
            matching: .triggerComponents,
            matchingPolicy: .nextTime
        )

        let trigger: UNNotificationTrigger
        if let triggerDate = triggerDate,
            Calendar.current.isDateInToday(lastGoalDate),
            Calendar.current.isDateInToday(triggerDate) {
            // skip to tomorrow using a time interval trigger.
            guard let tomorrow = Calendar.current.nextDate(after: triggerDate, matching: .triggerComponents, matchingPolicy: .nextTime) else {
                return
            }
            let now = Date()
            let timeInterval = tomorrow.timeIntervalSince1970 - now.timeIntervalSince1970

            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            print("Using time trigger in \(timeInterval) seconds.")
        } else {
            // Use a calendar trigger that will automatically repeat.
            trigger = UNCalendarNotificationTrigger(dateMatching: .triggerComponents, repeats: true)
            print("Setting calendar trigger for next trigger time.")
        }

        let request = UNNotificationRequest(identifier: .reminderNotificationIdentifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current()
            .add(request)
    }
}

extension DateComponents {
    static let triggerComponents = DateComponents(hour: 9, minute: 0)
}

extension String {
    static let reminderNotificationIdentifier = "reminder"
}

final class NotificationCoordinatorAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            NotificationCoordinator.self,
            initializer: NotificationCoordinatorImpl.init
        ).inObjectScope(.container)
    }
}
