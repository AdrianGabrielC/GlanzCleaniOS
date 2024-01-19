//
//  WorkDetailsViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation


class WorkDetailsViewModel: ObservableObject {
    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }
    
    func getTotalIncome(_ pricePerHour: Decimal?, _ hoursWorked: Decimal?) -> Double {
        if let pricePerHour = pricePerHour, let hoursWorked = hoursWorked {
            return NSDecimalNumber(decimal: pricePerHour).doubleValue * NSDecimalNumber(decimal: hoursWorked).doubleValue
        }
        else {
            return 0.0
        }
    }
    
    func getDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM dd, yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    func getHour(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
              
              if let date = dateFormatter.date(from: dateString) {
                  let outputFormatter = DateFormatter()
                  outputFormatter.dateFormat = "HH:mm"
                  return outputFormatter.string(from: date)
              } else {
                  return "Invalid Date"
              }
      }
    
    func getProfit() -> Double {
        //let total = getTotalIncome(object?.pricePerHour, object?.hoursWorked)
        //return total - (total * 0.16)
        return 0
    }
}
