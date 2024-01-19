//
//  InvoiceService.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 19.01.2024.
//

import Foundation

class InvoiceService {
    func getInvoices(page: Int, pageSize: Int) async -> APIResponse<GET.Invoice> {
        guard let response: [GET.Invoice] = try? await APIRequest.request(apiRouter: .getInvoices(page: page, pageSize: pageSize)) else { return APIResponse(status: .Failure, message: "Failed to retrieve invoices", data: nil) }
        return APIResponse(status: .Success, message: "Invoices successfully retrieved", data: response)
    }

    func getInvoicesById(invoiceId: String) async -> APIResponse<GET.Invoice> {
        guard let response: GET.Invoice = try? await APIRequest.request(apiRouter: .getInvoiceById(invoiceId: invoiceId)) else { return APIResponse(status: .Failure, message: "Failed to retrieve invoice", data: nil) }
        return APIResponse(status: .Success, message: "Invoice successfully retrieved", data: [response])
    }

    func createInvoice(invoice: POST.Invoice) async -> APIResponse<POST.Invoice> {
        do {
            guard let data: POST.Invoice = try await APIRequest.request(apiRouter: .createInvoice(invoice: invoice)) else { return APIResponse(status: .Success, message: "Invoice successfully created!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Invoice successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to create invoice", data: nil) // Failed to create in API
        }
    }

    func editInvoice(invoiceId: String, invoice: PUT.Invoice) async -> APIResponse<PUT.Invoice> {
        do {
            guard let data: PUT.Invoice = try await APIRequest.request(apiRouter: .editInvoice(invoiceId: invoiceId, invoice: invoice)) else { return APIResponse(status: .Success, message: "Invoice successfully edited!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Invoice successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to edit invoice", data: nil) // Failed to create in API
        }
    }

}
