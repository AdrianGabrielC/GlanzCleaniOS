//
//  WorkModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation

extension GET {
    struct Work:Codable,Identifiable {
        var id: String
        var dateStartTime: Date
        var address: String
        var customer: GET.Customer
        var facility: GET.Facility
        var operation: GET.Operation
        var hoursWorked: Decimal
        var workBreak: Int
        var pricePerHour: Decimal
        var status: String
        var employees: [GET.Employee]
        
        // Util Variables
        var employeeWork: [GET.EmployeeWork]
        var totalIncome: Decimal {
            self.pricePerHour * self.hoursWorked
        }
    }
}

extension POST {
    struct Work:Codable, DictionaryConvertible {
        var dateStartTime: String
        var customerId: String
        var facilityId: String
        var operationId: String
        var hoursWorked: Decimal
        var workBreak: Int
        var pricePerHour: Decimal
        var status: String
        var employeesInfo: [EmployeeInfo]
        var address: String
        
        struct EmployeeInfo:Codable {
            var employeeId: String
            var pricePerHour: Double
        }
    }
}

extension PUT {
    struct Work:Codable, DictionaryConvertible {
        var dateStartTime: Date
        var customer: GET.Customer
        var facility: GET.Facility
        var operation: GET.Operation
        var hoursWorked: Decimal
        var workBreak: Decimal
        var pricePerHour: Decimal
        var status: String
        var employeesInfo: [EmployeeInfo]
        var address: String
        
        struct EmployeeInfo:Codable {
            var id: String
            var pricePerHour: Decimal
        }
    }
}

extension DELETE {
    struct Work:Codable {
        var id: String
    }
}


