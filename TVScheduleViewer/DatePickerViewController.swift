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
        updateSelectedDate(newdate: datePicker.date)
        
        // Also store the selected date
        date = datePicker.date
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        // Reset the picker and display to today's date
        let currDate = Date()
        datePicker.date = currDate
        
        updateSelectedDate(newdate: currDate)
        
        date = currDate
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    func updateSelectedDate(newdate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        selectedDate.text = dateFormatter.string(from: newdate)
    }
}
