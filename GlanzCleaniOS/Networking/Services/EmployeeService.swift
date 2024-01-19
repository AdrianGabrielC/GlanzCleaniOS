//
//  EmployeeService.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation

class EmployeeService {
    func getEmployees(page: Int, pageSize: Int) async -> APIResponse<GET.Employee> {
        guard let response: [GET.Employee] = try? await APIRequest.request(apiRouter: .getEmployees(page: page, pageSize: pageSize)) else { return APIResponse(status: .Failure, message: "Failed to retrieve employees", data: nil) }
        return APIResponse(status: .Success, message: "Employees successfully retrieved", data: response)
    }

    func getEmployeesById(employeeId: String) async -> APIResponse<GET.Employee> {
        guard let response: GET.Employee = try? await APIRequest.request(apiRouter: .getEmployeeById(employeeId: employeeId)) else { return APIResponse(status: .Failure, message: "Failed to retrieve employee", data: nil) }
        return APIResponse(status: .Success, message: "Employee successfully retrieved", data: [response])
    }

    func editEmployee(employeeId: String, employee: PUT.Employee) async -> APIResponse<PUT.Employee> {
        do {
            guard let data: PUT.Employee = try await APIRequest.request(apiRouter: .editEmployee(employeeId: employeeId, employee: employee)) else { return APIResponse(status: .Success, message: "Employee successfully edited!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Employee successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to edit employee", data: nil) // Failed to create in API
        }
    }

    
}
