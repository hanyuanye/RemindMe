//
//  Date+Extensions.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import Foundation

extension Date {
    func standardString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        return dateFormatter.string(from: self)
    }
}
