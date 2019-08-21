//
//  ReminderEditorModel.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
import CoreData

class ReminderEditorModel {
    var reminders: [ReminderModel] = []
    var uniqueIds: Set<String> = []
    let coreDataManager = CoreDataManager()
    
    init() {
        loadData()
    }
    
    func loadData() {
        coreDataManager.fetchReminders()?.forEach { reminder in
            if let title = reminder.title, let body = reminder.body, let date = Date.standardDate(from: reminder.startDate), let uniqueId = reminder.uniqueId {
                let payload = ReminderPayload(
                    title: title,
                    subtitle: reminder.subtitle,
                    body: body,
                    imageName: reminder.imageName,
                    sound: reminder.sound,
                    timeInterval: Int(reminder.timeInterval),
                    startDate: date)
                let model = ReminderModel()
                model.payload = payload
                if let lastDate = Date.standardDate(from: reminder.lastSentDate) {
                    model.lastSentDate = lastDate
                }
                model.uniqueId = uniqueId
                uniqueIds.insert(uniqueId)
                reminders.append(model)
            }
        }
    }
    
    @discardableResult
    func addReminder(payload: ReminderPayload) -> ReminderModel? {
        guard let start = payload.startDate else {
            return nil
        }
        let model          = ReminderModel()
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
        
        coreDataManager.addReminder(payload: payload, startDate: model.start, uniqueId: model.uniqueId)

        return model
    }
    
    func deleteReminder(index: Int) {
        let id = reminders[index].uniqueId
        coreDataManager.deleteReminder(for: id)
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
