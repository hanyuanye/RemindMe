//
//  NotificationManager.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func buildNotification(payload: ReminderPayload) -> UNNotificationRequest? {
        let interval = TimeInterval(payload.timeInterval * 60 * 60)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = payload.title
        if let subtitle = payload.subtitle { content.subtitle = subtitle }
        content.body = payload.body
        return UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    }
}
