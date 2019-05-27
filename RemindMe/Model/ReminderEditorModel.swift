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
    var uniqueIds: Set<String> = []
    
    @discardableResult
    func addReminder(payload: ReminderPayload) -> ReminderModel? {
        guard let start = payload.startDate else {
            return nil
        }
        let model = ReminderModel()
        model.payload      = payload
        model.lastSentDate = start
        model.uniqueId     = generateUniqueId()
        reminders.append(model)
        if let request = NotificationManager.instance.buildNotification(payload: payload, id: model.uniqueId) {
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else {
            return nil
        }
        return model
    }
    
    func deleteReminder(index: Int) {
        let id = reminders[index].uniqueId
        NotificationManager.instance.removeNotification(for: id)
        uniqueIds.remove(id)
        reminders.remove(at: index)
    }
    
    private func generateUniqueId() -> String {
        var uniqueId = 0
        while uniqueIds.contains(String(uniqueId)) {
            uniqueId = uniqueId + 1
        }
        return String(uniqueId)
    }
}
