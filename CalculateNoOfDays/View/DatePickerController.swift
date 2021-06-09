//
//  ViewController.swift
//  CalculateNoOfDays
//
//  Created by Rosy Patel on 07/06/2021.
//

import UIKit

class DatePickerController: UIViewController {
    
    var viewModel = ViewModel()

    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var noOfDaysLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "d/M/yyyy"
        
        //start date
        startDatePicker.datePickerMode = .date
        startDateTextField.inputView = startDatePicker
        startDateTextField.text = dateFormatter.string(from: startDatePicker.date)
        
        //end date
        endDatePicker.datePickerMode = .date
        endDateTextField.inputView = endDatePicker
        endDateTextField.text = dateFormatter.string(from: endDatePicker.date)
       
    }

    @IBAction func startDatePickerTapped(_ sender: UIDatePicker) {
        startDateTextField.text = dateFormatter.string(from: sender.date)
    
    }
    
    @IBAction func endDatePickerTapped(_ sender: UIDatePicker) {
        endDateTextField.text = dateFormatter.string(from: sender.date)
        
    }
}

//MARK:- UITextFielDelegate

extension DatePickerController: UITextFieldDelegate{
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        startDateTextField.endEditing(true)
        endDateTextField.endEditing(true)
        if let start = startDateTextField.text, let end = endDateTextField.text {
            viewModel.fetchDates(startDate: start, endDate: end)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startDateTextField.endEditing(true)
        endDateTextField.endEditing(true)
        return true
    }
}

//MARK:- ViewModelDelegate

extension DatePickerController: ViewModelDelegate {
    func didUpdate(noOfDays: Int) {
        DispatchQueue.main.async {
            self.noOfDaysLabel.text = "\(noOfDays)"
        }
    }
}

