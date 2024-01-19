//
//  EmployeeWorkViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation

final class EmployeeWorkViewModel: ObservableObject {

    
    // MARK: Networking properties
    private var serviceManager: ServiceManager = ServiceManager()
    @Published var employee: GET.Employee
    
    // MARK: Utilities
    @Published var searchText = ""
    
    // MARK: Constructor
    init(employee:GET.Employee) {
        self.employee = employee
    }
    
    // MARK: Networking methods

    
    // MARK: Util methods
    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }
}
