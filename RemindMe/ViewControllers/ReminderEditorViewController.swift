//
//  ReminderEditorViewController.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import UIKit

class ReminderEditorViewController: UIViewController {

    @IBOutlet weak var reminderTableView: UITableView!
    
    var model = ReminderEditorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        reminderTableView.register(UINib(nibName: "ReminderEditorTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderEditorTableViewCell")
    }
}

// MARK: - UITableViewDelegate

extension ReminderEditorViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ReminderEditorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderEditorTableViewCell") as? ReminderEditorTableViewCell else {
            return UITableViewCell()
        }
        let reminder = model.reminders[indexPath.row]
        cell.configure(title: reminder.payload?.title,
                       body: reminder.payload?.body,
                       startDate: reminder.start,
                       nextReminder: reminder.nextReminder,
                       index: indexPath.row)
        cell.didDelete = { index in
            self.model.deleteReminder(index: index)
            self.reminderTableView.reloadData()
        }
        return cell
    }
}

// MARK: - IBActions

extension ReminderEditorViewController {
    @IBAction func didTap(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let reminderEditorModalViewController = storyboard.instantiateViewController(withIdentifier: "ReminderEditorModalViewController") as? ReminderEditorModalViewController else {
            return
        }
        reminderEditorModalViewController.modalPresentationStyle = .overCurrentContext
        reminderEditorModalViewController.didAddReminder = { payload in
            self.model.addReminder(payload: payload)
            self.reminderTableView.reloadData()
        }
        present(reminderEditorModalViewController, animated: true, completion: nil)
    }
}
