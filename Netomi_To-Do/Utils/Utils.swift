//
//  Utils.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import UIKit

class Utils {
    
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func getDateStringFromDate(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy hh:mm a"
        return dateFormatter.string(from: date)
    }
    static func getTimeStringFromDate(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    static func compareDate(itemDate:Date)-> DateDisplayFormat{
        
        let currentDate = Date()
        let calendar = Calendar.current
        let isSameDay = calendar.isDate(itemDate, inSameDayAs: currentDate) // Check if itemDate is on the same day as currentDate

        if itemDate < currentDate {
            return .expired
        }else if isSameDay {
           return .today
        }   else {
           return .nextDay
        }
    }
    
}
