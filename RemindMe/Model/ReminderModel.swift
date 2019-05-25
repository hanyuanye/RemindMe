//
//  ReminderModel.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import Foundation

struct ReminderPayload {
    var title: String
    var subtitle: String?
    var body: String
    var imageName: String?
    var sound: String?
    var timeInterval: Int
    var startDate: Date? = nil
}

class ReminderModel {
    var lastSentDate: Date? = nil
    var nextReminderDate: Date? {
        guard let payload = payload, let lastSentDate = lastSentDate else {
            return nil
        }
        return Calendar.current.date(byAdding: .hour, value: payload.timeInterval, to: lastSentDate)
    }
    var title: String? {
        return payload?.title
    }
    var start: String? {
        return payload?.startDate?.standardString()
    }
    var nextReminder: String? {
        return nextReminderDate?.standardString()
    }
    var payload: ReminderPayload? = nil
}
