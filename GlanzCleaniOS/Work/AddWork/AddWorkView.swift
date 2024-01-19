//
//  AddWorkView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct AddWorkView: View {
    @State private var toast: Toast? = nil
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddWorkViewModel()
    @State var showWorkType = false
    @State var showFacilities = false
    @State var showCustomers = false
    @State var showOperations = false
    @State var showEmployees = false
    @State var work: GET.Work? = nil
    
    
    // TEST PROP
    @State var isLoading = false

    
    
    
    struct TempObj: Identifiable {
        var id = UUID().uuidString
        var name:String
    }
    var objects = [TempObj(name: "What is the name of your best friend?"), TempObj(name: "What is the name of your best movie?"), TempObj(name: "What is the name of your best game?")]
    
    @ViewBuilder
    func SelectBtn(img:String, title:String, name:String?, placeholder: String) -> some View {
        HStack {
            Image(systemName: "building")
            Text(title).font(.custom("Poppins-SemiBold", size: 16))
            Spacer()
            if let name = name {
                Text(name).font(.custom("Poppins-SemiBold", size: 16))
            }
            else {
                Text(placeholder).foregroundStyle(.gray).font(.custom("Poppins-Regular", size: 16))
            }
            Image(systemName: "chevron.down")
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
    
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(alignment:.leading) {
                    Image("AddWorkImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .overlay(Circle().fill(Color("MainYellow")).offset(x:260))
                        .padding(.bottom, 50)
                    
                    
                    // MARK: TIME
                    Group {
                        Text("Time").font(.custom("Poppins-Bold", size: 18))
                        
                        DateFieldComponent(sfSymbolName: "calendar",
                                           placeHolder: "Date",
                                           prompt: "",
                                           field: $viewModel.date,
                                           isValid: true)
                        .font(.custom("Poppins-Semibold", size: 16))
                        .padding(.bottom, 10)
                        HourFieldComponent(sfSymbolName: "calendar",
                                           placeHolder: "Begin",
                                           prompt: "",
                                           field: $viewModel.beginHour,
                                           isValid: true)
                        .font(.custom("Poppins-Semibold", size: 16))
                        .padding(.bottom, 10)
                        HoursStepperFieldComponent(sfSymbolName: "timer",
                                              placeHolder: "Hours worked",
                                              units: "h",
                                              field: $viewModel.hoursWorked)
                        .font(.custom("Poppins-Semibold", size: 16))
                        .padding(.bottom, 10)
                        MinutesStepperFieldComponent(sfSymbolName: "timer",
                                              placeHolder: "Work break",
                                              units: "min",
                                              field: $viewModel.workBreak)
                        .font(.custom("Poppins-Semibold", size: 16))
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    
                    // MARK: INCOME
                    Group {
                        Text("Income")
                            .font(.custom("Poppins-Bold", size: 18))
                            //.foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                        NumberFieldComponent(sfSymbolName: "banknote",
                                             placeHolder: "Price per hour",
                                             prompt: viewModel.pricePerHourPrompt,
                                             field: $viewModel.pricePerHour,
                                             isValid: viewModel.isPricePerHourValid)
                        
                        .font(.custom("Poppins-Semibold", size: 16))
                        .padding(.bottom, viewModel.pricePerHour > 0 ? 10 : 0)
                        if (viewModel.pricePerHour <= 0) {
                            Text("Required. Price per hour must be greater than 0.")
                                .font(.custom("Poppins-SemiBold", size: 12))
                                .padding(.bottom, 10)
                                .foregroundStyle(.red)
                        }
                        NumberFieldComponent(sfSymbolName: "banknote",
                                             placeHolder: "Total",
                                             prompt: "",
                                             field: $viewModel.total,
                                             isValid: true)
                        .font(.custom("Poppins-Semibold", size: 16))
                        .disabled(true)
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    
                    // MARK: DETAILS
                    Group {
                        Text("Details")
                            .font(.custom("Poppins-Bold", size: 18))
                        // CUSTOMER
                        Button {
                            Task {
                                showCustomers = true
                                let result = await viewModel.getCustomers()
                                
                            }
                        }label: {
                            SelectBtn(img: "building", 
                                      title: "Customer",
                                      name: viewModel.selectedCustomer == nil ? nil : viewModel.selectedCustomer?.name ?? "",
                                      placeholder: "Select a customer")
                        }.buttonStyle(.plain)
                            .padding(.bottom, viewModel.selectedCustomer == nil ? 0 : 10)
                        if viewModel.selectedCustomer == nil {
                            Text("Required. A customer is required.").font(.custom("Poppins-Bold", size: 12)).foregroundStyle(.red).padding(.bottom, 10)
                        }
                        // FACILITY
                        Button {
                            Task {
                                showFacilities = true
                                let result = await viewModel.getFacilities()
                            }
                        }label: {
                            SelectBtn(img: "building",
                                      title: "Facility",
                                      name: viewModel.selectedFacility == nil ? nil : viewModel.selectedFacility?.name ?? "",
                                      placeholder: "Select a facility")
                        }.buttonStyle(.plain)
                            .padding(.bottom, 10)
                            //.padding(.bottom, viewModel.selectedFacility == nil ? 0 : 10)
//                        if viewModel.selectedFacility == nil {
//                            Text("Required. A facility is required.").font(.custom("Poppins-Bold", size: 12)).foregroundStyle(.red).padding(.bottom, 10)
//                        }
                        // OPERATIONS
                        Button {
                            Task {
                                showOperations = true
                                let result = await viewModel.getOperations()
                                
                            }
                        }label: {
                            SelectBtn(img: "briefcase.fill",
                                      title: "Operation",
                                      name: viewModel.selectedOperation == nil ? nil : viewModel.selectedOperation?.name ?? "",
                                      placeholder: "Select an operation")
                        }.buttonStyle(.plain)
                            .padding(.bottom, 40)
                            //.padding(.bottom, viewModel.selectedOperation == nil ? 0 : 10)
//                        if viewModel.selectedOperation == nil {
//                            Text("Required. An operation is required.").font(.custom("Poppins-Bold", size: 12)).foregroundStyle(.red).padding(.bottom, 10)
//                        }
                        // LOCATION ADDRESS
//                        BlackTextFieldComponent(sfSymbolName: "house",
//                                                placeHolder: "Location address",
//                                                prompt: viewModel.selectedLocationAddress.errInfo,
//                                                field: $viewModel.selectedLocationAddress.input,
//                                                isValid: viewModel.selectedLocationAddress.isValid,
//                                                type: .textField)
//                        .padding(.bottom, 10)

                  
                    }
                    .padding(.horizontal)
            
                    // EMPLOYEES
                    Group {
                        HStack {
                            Text("Employees")
                                .font(.custom("Poppins-Bold", size: 18))
                            Spacer()
                            Button{
                                showEmployees = true
                            }label: {
                                Image(systemName: "plus")
                                    .padding(5)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                            }

                        }
                        if viewModel.selectedEmployees.isEmpty {
                            Text("Requried. At least one employee is required.")
                                .font(.custom("Poppins-Regular", size: 12))
                                .foregroundColor(.red)
                                .bold()
                        }
                        VStack {
                            VStack {
                                ForEach(viewModel.selectedEmployees.indices, id:\.self) { index in
                                    VStack(spacing: 10) {
                                        HStack {
                                            Image("ProfileImg")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:40)
                                            VStack(alignment:.leading, spacing:1) {
                                                HStack(spacing: 5) {
                                                    Circle().fill(viewModel.selectedEmployees[index].isActive ? .green : .red).frame(width: 10)
                                                    Text("\(viewModel.selectedEmployees[index].firstName) \(viewModel.selectedEmployees[index].lastName)")
                                                        .font(.custom("Poppins-Bold", size: 16))
                                                        .foregroundColor(.white)
                                                }
                                                Text(viewModel.selectedEmployees[index].email).font(.custom("Poppins-SemiBold", size: 12)).foregroundStyle(.gray)
                                            }
                                            Spacer()
                                            if let index2 = viewModel.employeeWork.firstIndex(where: {$0.employeeId == viewModel.selectedEmployees[index].id}) {
                                                Text("$\(viewModel.employeeWork[index2].pricePerHour, specifier:"%.2f")").font(.custom("Poppins-Regular", size: 22)).foregroundStyle(.green)
                                            }
                                           
                                            Button {
                                                viewModel.selectedEmployees.removeAll(where: {$0.id == viewModel.selectedEmployees[index].id})
                                                viewModel.employeeWork.removeAll(where: {$0.employeeId == viewModel.selectedEmployees[index].id})
                                            }label: {
                                                Image(systemName: "minus.circle").foregroundColor(.red).font(.title2)
                                            }
                                        }
                                        if let index2 = viewModel.employeeWork.firstIndex(where: {$0.employeeId == viewModel.selectedEmployees[index].id}) {
                                            Slider(value: $viewModel.employeeWork[index2].pricePerHour, in: 1...50, step: 0.5).padding(.horizontal).tint(.green)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: objects.count > 0 ? 1 : 0)
                                .opacity(viewModel.selectedEmployees.isEmpty ? 0 : 1)
                        )
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    YellowButton(text: work == nil ? "Add work" : "Save") {
                        if viewModel.isFormValid {
                            Task {
                                isLoading = true
                                let result = await viewModel.postWork()
                                isLoading = false
                                toast = Toast(style: result == .Success ? .success : .error, message: result == .Success ? "Work successfully added!" : "Failed to add work!")
                            }
                        }
                        else {
                            toast = Toast(style: .warning, message: "Invalid data. Please fill all the required fields!")
                        }

                    }
                    //.disabled(viewModel.isFormValid ? false : true)
                    //.opacity(viewModel.isFormValid ? 1 : 0.5)
                    .padding()
                    .padding(.bottom)
                    Spacer()
                }
            }.disabled(viewModel.isLoading)
            if viewModel.isLoading {
                LoadingView(loadingType: .upload).brightness(0.5)
            }
        }
        .toastView(toast: $toast)
        .brightness(viewModel.isLoading ? -0.5 : 0)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text(work == nil ? "Add work" : "Edit Work") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
        .onAppear {
            if let work = work {
                // It means we want to edit an existing work and we have to populate the form with the current values
            }
        }
        .sheet(isPresented: $showCustomers) {
            SelectItemSheet(title: "Select customer", 
                            viewModel: viewModel,
                            showCurrentSheet: $showCustomers,
                            canAddNewItem: true,
                            addItemTitle: "Add customer",
                            addItemName:"Customer",
                            addItemImg:"building",
                            addItemPlaceholder: "Add customer",
                            type: .customer)
                .onDisappear {
                    if let selectedCustomer = viewModel.selectableObjects.first(where: { $0.selected }) {
                        viewModel.selectedCustomer = GET.Customer(id: selectedCustomer.id, name: selectedCustomer.name)
                    }
                }
            
        }
        .sheet(isPresented: $showFacilities) {
            SelectItemSheet(title: "Select facility", 
                            viewModel: viewModel,
                            showCurrentSheet: $showFacilities,
                            canAddNewItem: true,
                            addItemTitle: "Add facility",
                            addItemName:"Facility",
                            addItemImg:"building",
                            addItemPlaceholder: "Add facility",
                            type: .facility)
                .onDisappear {
                    if let selectedFacility = viewModel.selectableObjects.first(where: { $0.selected }) {
                        viewModel.selectedFacility = GET.Facility(id: selectedFacility.id, name: selectedFacility.name)
                    }
                }
        }
        .sheet(isPresented: $showOperations) {
            SelectItemSheet(title: "Select operation", 
                            viewModel: viewModel,
                            showCurrentSheet: $showOperations,
                            canAddNewItem: true,
                            addItemTitle: "Add operation",
                            addItemName:"Operation",
                            addItemImg:"briefcase.fill",
                            addItemPlaceholder: "Add operation",
                            type: .operation)
                .onDisappear {
                    if let selectedOperation = viewModel.selectableObjects.first(where: { $0.selected }) {
                        viewModel.selectedOperation = GET.Operation(id: selectedOperation.id, name: selectedOperation.name)
                    }
                }
        }
        .sheet(isPresented: $showEmployees) {
            SelectItemSheet(title: "Select employees",
                            viewModel: viewModel,
                            showCurrentSheet: $showEmployees, 
                            allowMultipleSelections: true,
                            canAddNewItem: false,
                            type: .employee)
                .onDisappear {
                    // Manage selected employees
                    viewModel.selectableObjects.forEach { employee in
                        // If the current selectable employee is selected and is not in the selected employees array
                        if employee.selected, viewModel.selectedEmployees.contains(where: {$0.id == employee.id}) == false, let employeeToAdd = viewModel.employees.first(where: {$0.id == employee.id})  {
                            viewModel.selectedEmployees.append(employeeToAdd)
                        }
                        // If the current employee is not selected, check if it is in the selectedEmployeeArray case in which deselect it
                        else if employee.selected == false {
                            if viewModel.selectedEmployees.contains(where: {$0.id == employee.id}) {
                                viewModel.selectedEmployees.removeAll(where: {$0.id == employee.id})
                            }
                        }
                    }
                    // Add employee work for each employee
                    viewModel.employeeWork = []
                    viewModel.selectedEmployees.forEach { employee in
                        viewModel.employeeWork.append(.init(employeeId: employee.id, pricePerHour: 1))
                    }
                }
        }
    }
}

struct AddWorkView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkView().preferredColorScheme(.dark)
    }
}



