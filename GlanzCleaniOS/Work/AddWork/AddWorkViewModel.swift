//
//  AddWorkViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation

@MainActor
class AddWorkViewModel: SelectableObjectsProvider, ObservableObject {
    
    var serviceManager = ServiceManager()
    @Published var isLoading = false
    
    // MARK: FORM PROPERTIES
    // TIME
    @Published var date: Date = Date.now
    @Published var beginHour: Date = Date.now
    @Published var workBreak: Int = 0
    @Published var hoursWorked: Int = 1 {
        didSet {
            total = pricePerHour * Double(hoursWorked)
        }
    }
    
    // INCOME
    @Published var pricePerHour: Double = 0 {
        didSet {
            total = pricePerHour * Double(hoursWorked)
        }
    }
    @Published var isPricePerHourValid = true
    @Published var total: Double = 0
    var pricePerHourPrompt = "Income cannot be negative!"
    var totalPrompt = "Income cannot be negative!"
    var workBreakPrompt = "Work break cannot be negative!"
    
    // DETAILS
    @Published var employees: [GET.Employee] = []
    @Published var employeeWork: [POST.Work.EmployeeInfo] = []
    @Published var selectedCustomer: GET.Customer?
    @Published var selectedFacility: GET.Facility?
    @Published var selectedOperation: GET.Operation?
    @Published var address = StringInput(errInfo: "Location address cannot exceed 200 characters!",
                                                  validators: [DataValidator(validationStrategy: EmptyValidationStrategy()),DataValidator(validationStrategy: LengthValidationStrategy(200))])
    @Published var selectedEmployees: [GET.Employee] = []
    
    // SELECTABLE OBJECTS
    @Published var selectableObjects: [SelectableObject] = []
    @Published var newSelectableObject: SelectableObject?
    
    // VALIDATION
    var isFormValid: Bool {
        return  hoursWorked > 0 && pricePerHour > 0 && selectedCustomer != nil && !selectedEmployees.isEmpty && !employeeWork.isEmpty
    }
    
    
    // MARK: NETWORKING
    func getCustomers() async -> APIResponseStatus {
        var result = await serviceManager.customerService.getCustomers(page: 1, pageSize: 10)
        guard let customers = result.data else {return .Failure}
        selectableObjects = []
        customers.forEach { customer in
            var isAlreadySelected = selectedCustomer?.id == customer.id
            selectableObjects.append(SelectableObject(id: customer.id, name: customer.name, selected: isAlreadySelected, img: "building"))
        }
        return .Success
    }
    
    func getFacilities() async -> APIResponseStatus {
        var result = await serviceManager.facilityService.getFacilities(page: 1, pageSize: 10)
        guard let facilities = result.data else {return .Failure}
        selectableObjects = []
        facilities.forEach { facility in
            var isAlreadySelected = selectedFacility?.id == facility.id
            selectableObjects.append(SelectableObject(id: facility.id, name: facility.name, selected: isAlreadySelected, img: "building"))
        }
        return .Success
    }
    
    func getOperations() async -> APIResponseStatus {
        var result = await serviceManager.operationService.getOperations(page: 1, pageSize: 10)
        guard let operations = result.data else {return .Failure}
        selectableObjects = []
        operations.forEach { operation in
            var isAlreadySelected = selectedOperation?.id == operation.id
            selectableObjects.append(SelectableObject(id: operation.id, name: operation.name, selected: isAlreadySelected, img: "briefcase"))
        }
        return .Success
    }
    
    func getEmployees() async -> APIResponseStatus {
        var result = await serviceManager.employeeService.getEmployees(page: 1, pageSize: 10)
        guard let employees = result.data else {return .Failure}
        self.employees = employees
        selectableObjects = []
        employees.forEach { employee in
            let isAlreadySelected = self.selectedEmployees.contains(where: {$0.id == employee.id})
            selectableObjects.append(SelectableObject(id: employee.id, 
                                                      name: employee.firstName,
                                                      secondaryName: employee.lastName,
                                                      isActive: employee.isActive,
                                                      email: employee.email,
                                                      selected: isAlreadySelected,
                                                      assetImg: "ProfileImg"))
        }
        return .Success
    }

    func postWork() async -> APIResponseStatus {
        if let customerId = self.selectedCustomer?.id, let facilityId = self.selectedFacility?.id, let operationId = self.selectedOperation?.id {
            // Format the date
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
               let formattedDate = dateFormatter.string(from: self.beginHour)
               
            var workToAdd = POST.Work(dateStartTime: formattedDate,
                                      customerId: customerId,
                                      facilityId: facilityId,
                                      operationId: operationId,
                                      hoursWorked: Decimal(self.hoursWorked),
                                      workBreak: self.workBreak,
                                      pricePerHour: Decimal(self.pricePerHour),
                                      status: "pending",
                                      employeeInfo: self.employeeWork,
                                      address: self.address.input)
            let result = await serviceManager.workService.createWork(work: workToAdd)
            return result.status
        }
        return .Failure
    }

    func reset() {
        date = Date.now
        beginHour = Date.now
        workBreak = 0
        hoursWorked = 0
        pricePerHour = 0
        isPricePerHourValid = false
        total = 0
        selectedCustomer = nil
        selectedFacility = nil
        selectedOperation = nil
        address = StringInput(errInfo: "Location address cannot exceed 200 characters!",
                                                      validators: [DataValidator(validationStrategy: LengthValidationStrategy(200))])
        selectedEmployees = []
        employeeWork = []
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dateString = dateFormatter.string(from: date)

        return dateString
    }
    
    // MARK: Selectable objects
    func getData(type: SelectableObjectType) async -> APIResponseStatus {
        switch type {
        case .customer: return await getCustomers()
        case .facility: return await getFacilities()
        case .operation: return await getOperations()
        case .employee: return await getEmployees()
        }
    }
    
    func addItem(type: SelectableObjectType) async -> APIResponseStatus {
        if let newItem = self.newSelectableObject {
            switch type {
            case .customer:
                let newCustomer = POST.Customer(name: newItem.name)
                let result =  await serviceManager.customerService.createCustomer(customer: newCustomer)
                if result.status == .Success {
                    await getCustomers()
                    return .Success
                }
                else {
                    return .Failure
                }
            case .facility:
                let newFacility = POST.Facility(name: newItem.name)
                let result = await serviceManager.facilityService.createFacility(facility: newFacility)
                if result.status == .Success {
                    await getFacilities()
                    return .Success
                }
                else {
                    return .Failure
                }
            case .operation:
                let newOperation = POST.Operation(name: newItem.name)
                let result = await serviceManager.operationService.createOperation(operation: newOperation)
                if result.status == .Success {
                    await getOperations()
                    return .Success
                }
                else {
                    return .Failure
                }
            default :
                return .Failure
            }
        }
        else {
            return .Failure
        }
    }
}
