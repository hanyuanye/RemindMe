//
//  ReminderEditorTableViewCell.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import UIKit

class ReminderEditorTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var nextReminderLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var index: Int = 0
    var didDelete: ((Int) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String?, body: String?, startDate: String?, nextReminder: String?, index: Int) {
        titleLabel.text = title
        bodyLabel.text = body
        startDateLabel.text = startDate
        nextReminderLabel.text = nextReminder
        self.index = index
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        didDelete?(index)
    }
}
