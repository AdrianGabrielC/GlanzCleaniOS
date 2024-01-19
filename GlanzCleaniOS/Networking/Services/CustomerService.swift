//
//  CustomerService.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 18.01.2024.
//

import Foundation

class CustomerService {
    func getCustomers(page: Int, pageSize: Int) async -> APIResponse<GET.Customer> {
        guard let response:[GET.Customer] = try? await APIRequest.request(apiRouter: .getCustomers(page: page, pageSize: pageSize)) else { return APIResponse(status: .Failure, message: "Failed to retrieve customers", data: nil) }
        return APIResponse(status: .Success, message: "Customers successfully retrieved", data: response)
    }
    
    func getCustomersById(customerId: String) async -> APIResponse<GET.Customer> {
        guard let response:GET.Customer = try? await APIRequest.request(apiRouter: .getCustomerById(customerId: customerId)) else {return APIResponse(status: .Failure, message: "Failed to retrieve customer", data: nil)}
        return APIResponse(status: .Success, message: "Customer successfully retrieved", data: [response])
    }
    
    func createCustomer(customer: POST.Customer) async -> APIResponse<POST.Customer> {
        do {
            guard let data: POST.Customer = try await APIRequest.request(apiRouter: .createCustomer(customer: customer)) else {return APIResponse(status: .Success, message: "Customer successfully created!", data: nil)} // Created but not returned from API
            return APIResponse(status: .Success, message: "Customer succesfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to create customer", data: nil) // Failed to create in API
        }
    }
    
    func editCustomer(customerId: String, customer: PUT.Customer) async -> APIResponse<PUT.Customer> {
        do {
            guard let data: PUT.Customer = try await APIRequest.request(apiRouter: .editCustomer(customerId: customerId, customer: customer)) else {return APIResponse(status: .Success, message: "Customer successfully edited!", data: nil)} // Created but not returned from API
            return APIResponse(status: .Success, message: "Customer succesfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to edit customer", data: nil) // Failed to create in API
        }
    }
    
    
}
