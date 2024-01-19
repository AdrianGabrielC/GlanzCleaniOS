//
//  OperationService.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 19.01.2024.
//

import Foundation

class OperationService {
    func getOperations(page: Int, pageSize: Int) async -> APIResponse<GET.Operation> {
        guard let response: [GET.Operation] = try? await APIRequest.request(apiRouter: .getOperations(page: page, pageSize: pageSize)) else { return APIResponse(status: .Failure, message: "Failed to retrieve operations", data: nil) }
        return APIResponse(status: .Success, message: "Operations successfully retrieved", data: response)
    }

    func getOperationsById(operationId: String) async -> APIResponse<GET.Operation> {
        guard let response: GET.Operation = try? await APIRequest.request(apiRouter: .getOperationById(operationId: operationId)) else { return APIResponse(status: .Failure, message: "Failed to retrieve operation", data: nil) }
        return APIResponse(status: .Success, message: "Operation successfully retrieved", data: [response])
    }

    func createOperation(operation: POST.Operation) async -> APIResponse<POST.Operation> {
        do {
            guard let data: POST.Operation = try await APIRequest.request(apiRouter: .createOperation(operation: operation)) else { return APIResponse(status: .Success, message: "Operation successfully created!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Operation successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to create operation", data: nil) // Failed to create in API
        }
    }

    func editOperation(operationId: String, operation: PUT.Operation) async -> APIResponse<PUT.Operation> {
        do {
            guard let data: PUT.Operation = try await APIRequest.request(apiRouter: .editOperation(operationId: operationId, operation: operation)) else { return APIResponse(status: .Success, message: "Operation successfully edited!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Operation successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to edit operation", data: nil) // Failed to create in API
        }
    }

}
