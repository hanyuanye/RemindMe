//
//  ReminderEditorModel.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import Foundation
import UserNotifications

class ReminderEditorModel {
    var reminders: [ReminderModel] = []
    
    @discardableResult
    func addReminder(payload: ReminderPayload) -> ReminderModel? {
        guard let start = payload.startDate else {
            return nil
        }
        let model = ReminderModel()
        model.payload = payload
        model.lastSentDate = start
        reminders.append(model)
        if let request = NotificationManager.instance.buildNotification(payload: payload) {
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else {
            return nil
        }
        return model
    }
    
    func deleteReminder(index: Int) {
        
    }
}
