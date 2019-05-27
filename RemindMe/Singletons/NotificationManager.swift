//
//  NotificationManager.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func buildNotification(payload: ReminderPayload, id: String) -> UNNotificationRequest? {
        let interval = TimeInterval(payload.timeInterval * 60 * 60)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = payload.title
        if let subtitle = payload.subtitle { content.subtitle = subtitle }
        content.body = payload.body
        return UNNotificationRequest(identifier: id, content: content, trigger: trigger)
    }
    
    func removeNotification(for id: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            for request in requests {
                if request.identifier == id {
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
                }
            }
        }
    }
}
