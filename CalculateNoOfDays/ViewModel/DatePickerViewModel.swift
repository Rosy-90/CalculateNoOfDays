//
//  ViewModel.swift
//  CalculateNoOfDays
//
//  Created by Rosy Patel on 09/06/2021.
//

import Foundation

protocol ViewModelDelegate {
    func didUpdate(noOfDays: Int)
}

class DatePickerViewModel {
    
    var delegate: ViewModelDelegate?
    
    let monthDays:[Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var diffDays: Int = 0

    var startDay:Int = 0
    var startMonth:Int = 0
    var startYear:Int = 0
    
    var endDay:Int = 0
    var endMonth:Int = 0
    var endYear:Int = 0
    
    func fetchDates(startDate:String, endDate: String) {
       
        let myStartArray = startDate.components(separatedBy: "/")
        if let day = Int(myStartArray[0]), let month = Int(myStartArray[1]), let year = Int(myStartArray[2]) {
            startDay = day
            startMonth = month
            startYear = year
        }
        
        let myEndArray = endDate.components(separatedBy: "/")
        if let day = Int(myEndArray[0]), let month = Int(myEndArray[1]), let year = Int(myEndArray[2]) {
            endDay = day
            endMonth = month
            endYear = year
        }
        
        diffDays = difference(date1: MyDate(day: startDay, month: startMonth, year: startYear), date2: MyDate(day: endDay, month: endMonth, year: endYear))
        
        delegate?.didUpdate(noOfDays: diffDays)
        
    }
    
    func difference(date1: MyDate, date2: MyDate) -> Int {
        
        //start date
        var noOfDaysInDate1 = date1.day + date1.year * 365
        for i in 0...date1.month - 1 {
            noOfDaysInDate1 += monthDays[i]
        }
        
        //end date
        var noOfDaysInDate2 = date2.day + date2.year * 365
        for i in 0...date2.month - 1 {
            noOfDaysInDate2 += monthDays[i]
        }
        return noOfDaysInDate2 - noOfDaysInDate1
        
    }
    
}



