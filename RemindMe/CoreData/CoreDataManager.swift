//
//  CoreDataManager.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-06-02.
//  Copyright © 2019 HY. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addReminder(payload: ReminderPayload, startDate: String?, uniqueId: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        let reminder = NSManagedObject(entity: entity!, insertInto: context) as! Reminder
        reminder.title        = payload.title
        reminder.subtitle     = payload.subtitle
        reminder.body         = payload.body
        reminder.imageName    = payload.imageName
        reminder.sound        = payload.sound
        reminder.timeInterval = Int32(payload.timeInterval)
        reminder.startDate    = startDate
        reminder.lastSentDate = startDate
        reminder.uniqueId = uniqueId
        
        saveContext()
    }
    
    func deleteReminder(for uniqueId: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        request.returnsObjectsAsFaults = false
        
        guard let remindersData = try? context.fetch(request) else {
            return
        }
        
        remindersData.forEach { data in
            if let data = data as? NSManagedObject, let id = data.value(forKey: "uniqueId") as? String, id == uniqueId {
                context.delete(data)
            }
        }
        
        saveContext()
    }
    
    func fetchReminders() -> [Reminder]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        request.returnsObjectsAsFaults = false
        
        guard let remindersData = try? context.fetch(request) else {
            return nil
        }
        
        var reminders: [Reminder] = []
        
        remindersData.forEach { reminderData in
            if let reminderData = reminderData as? Reminder {
                reminders.append(reminderData)
            }
        }
        
        return reminders
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unresolved error \(error.localizedDescription))")
            }
        }
    }
}
