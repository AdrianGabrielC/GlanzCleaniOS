//
//  AddEmployeeViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation

final class AddEmployeeViewModel: ObservableObject {
    
    // MARK: Networking properties
    private var serviceManager: ServiceManager = ServiceManager()
    @Published var isLoading = false
    
    
    // MARK: Form properties
    @Published var firstName = StringInput(errInfo: "Required. First Name cannot contain digits or symbols.",
                                           validators: [ DataValidator(validationStrategy: LettersOnlyValidationStrategy()),
                                                         DataValidator(validationStrategy: LengthValidationStrategy(3))] )
    @Published var lastName = StringInput(errInfo: "Required. Last Name cannot contain digits or symbols.",
                                          validators: [ DataValidator(validationStrategy: LettersOnlyValidationStrategy()),
                                                        DataValidator(validationStrategy: LengthValidationStrategy(3))] )
    @Published var email = StringInput(errInfo: "Required. Invalid email address.",
                                       validators: [DataValidator(validationStrategy: EmailValidationStrategy())])
    @Published var phone = StringInput(errInfo: "Required. Phone cannot contain letters or symbols.",
                                       validators: [DataValidator(validationStrategy: PhoneValidationStrategy())])
    @Published var password = StringInput(errInfo: "Required. Password must contain at least one upper case letter, one digit, and more than six characters!",
                                          validators: [DataValidator(validationStrategy: PasswordValidationStrategy())])
    @Published var confirm_password = StringInput(errInfo: "",
                                                  validators: [DataValidator(validationStrategy: PasswordValidationStrategy())])
    
    var isFormValid: Bool {
        return firstName.isValid && lastName.isValid && email.isValid && phone.isValid && password.isValid && password.input == confirm_password.input
    }
    

    
    // MARK: Networking methods
    func addEmployee(employee: POST.Register) async -> APIResponseStatus {
        isLoading = true
        var result = await serviceManager.authenticationService.register(user: employee)
        isLoading = false
        return result.status
    }
    func editEmployee(employeeId:String, employee: PUT.Employee) async -> APIResponseStatus {
        isLoading = true
        var result = await serviceManager.employeeService.editEmployee(employeeId: employeeId, employee: employee)
        isLoading = false
        return result.status
    }
    
    func createRegisterEmployeeDto() -> POST.Register {
        var user = POST.Register()
        user.firstName = firstName.input
        user.lastName = lastName.input
        user.email = email.input
        user.phone = phone.input
        user.password = password.input
        return user
    }
    
    func createEditEmployeeDto(employee: GET.Employee) -> PUT.Employee {
        var editEmployee = PUT.Employee(firstName: employee.firstName,
                                        lastName: employee.lastName,
                                        isActive: employee.isActive,
                                        email: employee.email,
                                        phone: employee.phone,
                                        address: employee.address)
        return editEmployee
    }
}
