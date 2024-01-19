//
//  APIRouter.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
enum APIRouter {
    // MARK: Authentication
    case register(bodyParam: POST.Register)
    case login(bodyParam: POST.Login)
    case changePass(bodyParam: PUT.ChangePass)
    
    // MARK: EMPLOYEES
    case getEmployees(page: Int, pageSize: Int)
    case getEmployeeById(employeeId: String)
    case createEmployee(employee: POST.Employee)
    case editEmployee(employeeId: String, employee: PUT.Employee)
    case deleteEmployee(employeeId: String)
    
    // MARK: WORK
    case getWork(page: Int, pageSize: Int, year: Int?, month: Int?, day: Int?)
    case getWorkById(workId:String)
    case createWork(work: POST.Work)
    case editWork(workId:String, work: PUT.Work)
    case deleteWork(workId:String)
    
    // MARK: INVOICES
    case getInvoices(page: Int, pageSize: Int)
    case getInvoiceById(invoiceId: String)
    case createInvoice(invoice: POST.Invoice)
    case editInvoice(invoiceId: String, invoice: PUT.Invoice)
    case deleteInvoice(invoiceId: String)
    
    // MARK: CUSTOMERS
    case getCustomers(page: Int, pageSize: Int)
    case getCustomerById(customerId:String)
    case createCustomer(customer: POST.Customer)
    case editCustomer(customerId:String, customer: PUT.Customer)
    case deleteCustomer(customerId:String)
    
    // MARK: FACILITIES
    case getFacilities(page: Int, pageSize: Int)
    case getFacilityById(facilityId:String)
    case createFacility(facility: POST.Facility)
    case editFacility(facilityId:String, facility: PUT.Facility)
    case deleteFacility(facilityId:String)
    
    // MARK: OPERATIONS
    case getOperations(page: Int, pageSize: Int)
    case getOperationById(operationId:String)
    case createOperation(operation: POST.Operation)
    case editOperation(operationId:String, operation: PUT.Operation)
    case deleteOperation(operationId:String)
    
    // MARK: STATISTICS
    case getStatisticsForOneYear(year: Int)
    case getStatisticsForAllYears
    case getEmployeeRevenueStatisticsForOneYear(year: Int, employeeId: String)
    case getEmployeeHoursStatisticsForOneYear(year: Int, employeeId: String)
    
    var host: String {
        return "glanzclean-webapi-westgermany-dev-001.azurewebsites.net"
    }
    
    var path: String {
        switch self {
        // MARK: Authentication
        case .register: return "/api/auth/register"
        case .login: return "/api/auth/login"
        case .changePass: return "/api/auth/changePass"
        
        // MARK: Employees
        case .getEmployees: return "/api/employees"
        case .getEmployeeById(let employeeId): return "/api/employees/\(employeeId)"
        case .createEmployee: return "/api/employees"
        case .editEmployee(let employeeId, _): return "/api/employees/\(employeeId)"
        case .deleteEmployee(let employeeId): return "/api/employees/\(employeeId)"
            
            // MARK: WORK
        case .getWork: return "/api/work"
        case .getWorkById(let workId): return "/api/work/\(workId)"
        case .createWork: return "/api/work"
        case .editWork(let workId, _): return "/api/work/\(workId)"
        case .deleteWork(let workId): return "/api/work/\(workId)"
        
        // MARK: INVOICES
        case .getInvoices: return "/api/invoices"
        case .getInvoiceById(let invoiceId): return "/api/invoices/\(invoiceId)"
        case .createInvoice: return "/api/invoices"
        case .editInvoice(let invoiceId, _): return "/api/invoices/\(invoiceId)"
        case .deleteInvoice(let invoiceId): return "/api/invoices/\(invoiceId)"
            
        // MARK: CUSTOMERS
        case .getCustomers: return "/api/customers"
        case .getCustomerById(let customerId): return "/api/customers/\(customerId)"
        case .createCustomer: return "/api/customers"
        case .editCustomer(let customerId, _): return "/api/customers/\(customerId)"
        case .deleteCustomer(let customerId): return "/api/customers/\(customerId)"
            
        // MARK: FACILITIES
        case .getFacilities: return "/api/facilities"
        case .getFacilityById(let facilityId): return "/api/facilities/\(facilityId)"
        case .createFacility: return "/api/facilities"
        case .editFacility(let facilityId, _): return "/api/facilities/\(facilityId)"
        case .deleteFacility(let facilityId): return "/api/facilities/\(facilityId)"
            
        // MARK: OPERATIONS
        case .getOperations: return "/api/operations"
        case .getOperationById(let operationId): return "/api/operations/\(operationId)"
        case .createOperation: return "/api/operations"
        case .editOperation(let operationId, _): return "/api/operations/\(operationId)"
        case .deleteOperation(let operationId): return "/api/operations/\(operationId)"
            
        // MARK: STATISTICS
        case .getStatisticsForOneYear: return "/api/statistics/yearStats"
        case .getStatisticsForAllYears: return "/api/statistics/allyearsstats"
        case .getEmployeeRevenueStatisticsForOneYear: return "/api/statistics/employeeyearrevstats"
        case .getEmployeeHoursStatisticsForOneYear: return "/api/statistics/employeeYearHoursWorkedStats"
        }
    }
    
    var scheme: String {
        return "https"
    }
    
    var method: String {
        switch self {
        case .getEmployees, .getEmployeeById, .getInvoices, .getInvoiceById, .getWork, .getWorkById, .getCustomers, .getCustomerById, .getFacilities, .getFacilityById, .getOperations, .getOperationById, .getStatisticsForOneYear, .getStatisticsForAllYears, .getEmployeeRevenueStatisticsForOneYear, .getEmployeeHoursStatisticsForOneYear: return "GET"
        case .register, .login, .changePass, .createEmployee, .createInvoice, .createWork, .createCustomer, .createFacility, .createOperation: return "POST"
        case .editEmployee, .editInvoice, .editWork, .editCustomer, .editFacility, .editOperation: return "PUT"
        case .deleteEmployee, .deleteInvoice, .deleteWork, .deleteCustomer, .deleteFacility, .deleteOperation: return "DELETE"
   
        }
    }
    
    var queryParameters: [URLQueryItem] {
        switch self {
        case .register, .login, .changePass, .getEmployeeById, .createEmployee, .editEmployee, .deleteEmployee, .getInvoiceById, .createInvoice, .editInvoice, .deleteInvoice, .getWorkById, .createWork, .editWork, .deleteWork, .getCustomerById, .createCustomer, .editCustomer, .deleteCustomer, .getFacilityById, .createFacility, .editFacility, .deleteFacility, .getOperationById, .createOperation, .editOperation, .deleteOperation, .getStatisticsForAllYears:
            return []
        case .getWork(let page,let pageSize, let year,let month,let day): return [URLQueryItem(name: "page", value: "\(page)"),
                                                                                  URLQueryItem(name: "pageSize", value: "\(pageSize)"),
                                                                                  URLQueryItem(name: "year", value: year != nil ? "\(year!)" : nil),
                                                                                  URLQueryItem(name: "month", value: month != nil ? "\(month!)" : nil),
                                                                                  URLQueryItem(name: "day", value: day != nil ? "\(day!)" : nil)]
        case .getEmployees(let page, let pageSize), .getInvoices(let page, let pageSize), .getCustomers(let page,let pageSize), .getFacilities(let page, let pageSize), .getOperations(let page, let pageSize):
            return [URLQueryItem(name: "page", value: "\(page)"),
             URLQueryItem(name: "pageSize", value: "\(pageSize)")]
        case .getStatisticsForOneYear(let year): return [URLQueryItem(name: "Year", value: "\(year)")]
        case .getEmployeeRevenueStatisticsForOneYear(let year,let employeeId), .getEmployeeHoursStatisticsForOneYear(let year,let employeeId):
            return [URLQueryItem(name: "Year", value: "\(year)"),
                    URLQueryItem(name: "EmployeeId", value: "\(employeeId)")]

   
        }
    }
    
    var bodyParameters: Codable? {
        switch self {
        case .register(let bodyParam): return bodyParam
        case .login(let bodyParam): return bodyParam
        case .changePass(let bodyParam): return bodyParam
        case .createEmployee(let employee): return employee
        case .editEmployee(_, let employee): return employee
        case .createWork(let work): return work
        case .editWork(_, let work): return work
        case .createInvoice(let invoice): return invoice
        case .editInvoice(_, let invoice): return invoice
        case .createCustomer(let customer): return customer
        case .editCustomer(_, let customer): return customer
        case .createFacility(let facility): return facility
        case .editFacility(_, let facility): return facility
        case .createOperation(let operation): return operation
        case .editOperation(_, let operation): return operation

        default: return nil
        }
    }
}
