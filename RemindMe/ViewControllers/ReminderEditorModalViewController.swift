//
//  ReminderEditorModalViewController.swift
//  RemindMe
//
//  Created by Hanyuan Ye on 2019-05-25.
//  Copyright © 2019 HY. All rights reserved.
//

import UIKit

class ReminderEditorModalViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subTitleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var timeIntervalTextField: UITextField!
    
    var didAddReminder: ((ReminderPayload) -> ())? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTap(_ sender: UIButton) {
        guard let title = titleTextField.text, let body = bodyTextField.text, let timeIntervalString = timeIntervalTextField.text, let timeInterval = Int(timeIntervalString)  else {
            return
        }
        let payload = ReminderPayload(title: title, subtitle: subTitleTextField.text, body: body, imageName: nil, sound: nil, timeInterval: timeInterval, startDate: Date())
        didAddReminder?(payload)
        dismiss(animated: true, completion: nil)
    }
}
