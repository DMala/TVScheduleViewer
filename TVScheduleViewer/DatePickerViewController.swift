//
//  DatePickerViewController.swift
//  TVScheduleViewer
//
//  Created by Wendy-Anne Malaguti on 12/13/17.
//  Copyright © 2017 Watch City Software. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var date: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        selectedDate.text = dateFormatter.string(from: date)
        
        datePicker.date = date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func datePickerAction(_ sender: Any) {
        // Update the label displaying the string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.selectedDate.text = dateFormatter.string(from: datePicker.date)
        
        // Also store the selected date
        date = datePicker.date
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        
//        guard let button = sender as? UIBarButtonItem, button === doneButton else {
//            print("Hi!")
//            return
//        }
//    }
}
