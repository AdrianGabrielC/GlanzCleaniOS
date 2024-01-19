//
//  CalendarViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
@MainActor
class CalendarViewModel: ObservableObject {
    
    // MARK: Networking properties
    private var serviceManager: ServiceManager = ServiceManager()
    @Published var work: [GET.Work] =  []

    // MARK: Utilities
    @Published var isLoading = false
    @Published var searchText = ""
    
 
    // MARK: Networking methods
    func getWork(year:Int, month:Int?, day:Int?) async -> APIResponseStatus {
        isLoading = true
        let response = await serviceManager.workService.getWorks(page: 1, pageSize: 10, year: year, month: month, day: day)
        isLoading = false
        guard let work = response.data else {return .Failure}
        self.work = work
        return .Success
    }
    
    func getWorkById(workId: String) async -> APIResponse<GET.Work> {
        isLoading = true
        let response = await serviceManager.workService.getWorksById(workId: workId)
        isLoading = false
        return response
    }
    
    
    // MARK: - CALENDAR LOGIC
    func getCurrentMonth() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: currentDate)
    }
    
    func getPrettyDateString(_ inputDateStr: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd MMM yyyy"
        
        if let date = dateFormatterInput.date(from: inputDateStr) {
            return dateFormatterOutput.string(from: date)
        }
        
        return nil // Return nil if the input string is not in the expected format
    }
    
    func getMonthNameString(_ inputDateStr: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "MMMM"
        
        if let date = dateFormatterInput.date(from: inputDateStr) {
            return dateFormatterOutput.string(from: date)
        }
        
        return nil // Return nil if the input string is not in the expected format
    }
    
    func getDayOfMonthInt(from dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let dayOfMonth = calendar.component(.day, from: date)
            return dayOfMonth
        }
        
        return nil // Return nil for invalid date strings
    }
    
    func getMonthIntFromDateString(_ dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            return month
        } else {
            return nil // Parsing failed
        }
    }
    
    // Used in Day view in calendar to compute the height of each rectangle
    func convertDateStringToDouble(_ dateString: String) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let hour = Double(calendar.component(.hour, from: date))
            let minute = Double(calendar.component(.minute, from: date))
            let doubleValue = hour + (minute / 60.0)
            return doubleValue
        } else {
            // Invalid date string
            return nil
        }
    }
    
    func getDaysInMonth(_ month: Int) -> Int? {
        let calendar = Calendar.current
        
        // Ensure the month is within a valid range
        guard (1...12).contains(month) else {
            return nil
        }
        
        // Get the current year
        let currentYear = calendar.component(.year, from: Date())
        
        // Create a DateComponents object for the given year and month
        var dateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = month
        
        // Calculate the last day of the specified month
        if let date = calendar.date(from: dateComponents),
           let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        
        return nil
    }
    
    func getAbbreviatedDayOfWeek(year: Int, month: Int, day: Int) -> String? {
        let calendar = Calendar.current
        
        // Ensure the month is within a valid range
        guard (1...12).contains(month) else {
            return nil
        }
        
        // Ensure the day is within a valid range for the given month
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        guard let date = calendar.date(from: dateComponents) else {
            return nil
        }
        
        // Get the abbreviated name of the day of the week
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        return dateFormatter.string(from: date)
    }

    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }
    

    
    
}


