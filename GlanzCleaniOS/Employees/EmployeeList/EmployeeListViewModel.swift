//
//  EmployeeViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
@MainActor
final class EmployeeListViewModel: ObservableObject {
 
    // MARK: Networking properties
    private var serviceManager: ServiceManager = ServiceManager()
    @Published var employees: [GET.Employee] = []
    
    // MARK: Utilities
    @Published var isLoading = false
    @Published var searchText = ""
    
    // MARK: Networking methods
    func getEmployees() async -> APIResponseStatus {
        isLoading = true
        let response = await serviceManager.employeeService.getEmployees(page: 1, pageSize: 10)
        isLoading = false
        guard let employees = response.data else {return .Failure}
        self.employees = employees
        return .Success
    }
    
    func getEmployeeById(employeeId:String) async -> APIResponse<GET.Employee> {
        isLoading = true
        let response = await serviceManager.employeeService.getEmployeesById(employeeId: employeeId)
        isLoading = false
        return response
    }
    
    func editEmployee(employeeId:String, employee: PUT.Employee) async -> APIResponseStatus {
        isLoading = true
        let response = await serviceManager.employeeService.editEmployee(employeeId: employeeId, employee: employee)
        isLoading = false
        return response.status
    }
    
    
}
