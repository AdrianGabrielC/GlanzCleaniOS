//
//  AddEmployeeView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct AddEmployeeView: View {
    @Environment(\.dismiss) var dismiss
    var employee: GET.Employee? // When employee != nil, this view is for edit employee. When employee == nil, this view is for add employee
    
    @StateObject var viewModel: AddEmployeeViewModel = AddEmployeeViewModel()
    


    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Image("EmployeeInfoImg")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                
                
                VStack(spacing: 24) {
                    // First Name
                    EmployeeDetailsFormInput(icon: "person.crop.rectangle.fill",
                                             inputName: "First name",
                                             placeholder: "Enter first name",
                                             input: $viewModel.firstName.input,
                                             isInputValid: viewModel.firstName.isValid,
                                             errInfo:viewModel.firstName.errInfo)
                    
                    // Last Name
                    EmployeeDetailsFormInput(icon: "person.crop.rectangle.fill",
                                             inputName: "Last name",
                                             placeholder: "Enter last name",
                                             input: $viewModel.lastName.input,
                                             isInputValid: viewModel.lastName.isValid,
                                             errInfo:viewModel.lastName.errInfo)
                    
                    // Email
                    EmployeeDetailsFormInput(icon: "envelope.fill",
                                             inputName: "Email:",
                                             placeholder: "Enter email",
                                             input: $viewModel.email.input,
                                             isInputValid: viewModel.email.isValid,
                                             errInfo:viewModel.email.errInfo)
                    
                   // Phone
                    EmployeeDetailsFormInput(icon: "phone.fill",
                                             inputName: "Phone:",
                                             placeholder: "Enter phone",
                                             input: $viewModel.phone.input,
                                             isInputValid: viewModel.phone.isValid,
                                             errInfo:viewModel.phone.errInfo)
                    if employee == nil {
                        // Pass
                        EmployeeDetailsFormInput(icon: "lock",
                                                 inputName: "Password",
                                                 placeholder: "Enter password",
                                                 input: $viewModel.password.input,
                                                 isInputValid: viewModel.password.isValid,
                                                 errInfo: viewModel.password.errInfo,
                                                 isSecure: true)
                        
                        // Confirm pass
                        EmployeeDetailsFormInput(icon: "lock",
                                                 inputName: "Confirm Password",
                                                 placeholder: "Confirm password",
                                                 input: $viewModel.confirm_password.input,
                                                 isInputValid: viewModel.confirm_password.isValid,
                                                 errInfo: (viewModel.password.input != viewModel.confirm_password.input) && !viewModel.password.input.isEmpty && !viewModel.confirm_password.input.isEmpty ? "Passwords don't match!" : "",
                                                 isSecure: true)
                        
                        Info(text: "By adding an employee, a new account will be created!")
                    }
                    
                }.padding(.horizontal)
                Spacer()
                Button {
                    Task {
                        if employee == nil {
                            var result = await viewModel.addEmployee(employee: viewModel.createRegisterEmployeeDto())
                        }
                        else if let id = employee?.id, let employee = employee {
                            var result = await viewModel.editEmployee(employeeId: id, employee: viewModel.createEditEmployeeDto(employee: employee))
                        }
                    }
                } label :{
                    Text("Save")
                        .frame(maxWidth:.infinity, maxHeight: 40)
                        .background(Color("MainYellow"))
                        //.cornerRadius(10)
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 40)
                .disabled(viewModel.isFormValid ? false : true)
                .opacity(viewModel.isFormValid ? 1 : 0.5)
                .padding(.bottom, 80)
                .onAppear {
                    if let employee = employee {
                        viewModel.firstName.input = employee.firstName 
                        viewModel.lastName.input = employee.lastName 
                        viewModel.email.input = employee.email 
                        viewModel.phone.input = employee.phone 
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text(employee == nil ? "Add employee" : "Edit employee") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
}

#Preview {
    AddEmployeeView( employee: nil).preferredColorScheme(.dark)
}



struct EmployeeDetailsFormInput: View {
    var icon: String
    var inputName: String
    var placeholder: String
    @Binding var input: String
    var isInputValid: Bool
    var errInfo: String
    var isSecure = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                Text(inputName)
                Spacer()
                if isSecure {
                    SecureField(placeholder, text: $input)
                }
                else {
                    TextField(placeholder, text: $input)
                        .multilineTextAlignment(.trailing)
                        .backgroundStyle(.red)
                }
               
            }
            
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
            )
            .padding(.horizontal, 3)
            if !isInputValid {
                Text(errInfo)
                    .font(.custom("Poppins-SemiBold", size: 12))
                    .foregroundColor(.red)
                    .padding(.leading)
            }
        }.font(.custom("Poppins-SemiBold", size: 14))
    }
}
