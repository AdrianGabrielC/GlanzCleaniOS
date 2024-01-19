//
//  ServiceManager.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation

class ServiceManager: ObservableObject {
    var authenticationService = AuthenticationService()
    var employeeService = EmployeeService()
    var workService = WorkService()
    var invoiceService = InvoiceService()
    var customerService = CustomerService()
    var facilityService = FacilityService()
    var operationService = OperationService()
}
