//
//  EmployeeListView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct EmployeeListView: View {
    //@ObservedObject var serviceManager: ServiceManager
    //@StateObject var viewModel: EmployeeListViewModel
    
//    init(serviceManager: ServiceManager) {
//        self.serviceManager = serviceManager
//        self._viewModel = StateObject(wrappedValue: EmployeeListViewModel(serviceManager: serviceManager))
//    }
    @StateObject var viewModel = EmployeeListViewModel()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Text("Employees")
                            .font(.custom("Poppins-Bold", size: 28))
                        Image("EmployeesImg")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                    Spacer()
                }
                
                HStack {
                    CustomSearchBar(text: $viewModel.searchText)
                        .padding(.vertical)
                    NavigationLink {
                        AddEmployeeView(employee: nil)
                    }label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                          
                    }
                    NavigationLink {
                        NotificationsView()
                    }label: {
                        Image(systemName: "bell")
                            .font(.title2)
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(
                                Circle()
                                    .fill(.red)
                                    .frame(width:18)
                                    .offset(x: 15, y:-15)
                                    .overlay(
                                        Text("2")
                                            .offset(x: 15, y:-15)
                                            .font(.custom("Poppins-Bold", size: 12))
                                            .foregroundStyle(.white)
                                    )
                            )
                    }
                }
                ScrollView {
                    if viewModel.employees.isEmpty {
                        ProgressView().padding(.top, 150)
                    }
                    else {
                        ForEach(viewModel.employees) { employee in
                            NavigationLink {
                                EmployeeWorkView(employee: employee)
                            }label: {
                                HStack {
                                    Image("ProfileImg")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:40)
                                    VStack(alignment:.leading, spacing:1) {
                                        Text("\(employee.firstName ) \(employee.lastName )")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(.white)
                                        HStack(spacing: 3){
                                            Circle().fill(employee.isActive ? .green : .red).frame(width: 10)
                                            Text("\(employee.isActive ? "Active" : "Inactive")")
                                                .font(.custom("Poppins-SemiBold", size: 12))
                                                .font(.footnote)
                                                .foregroundColor(employee.isActive ? .green : .red)
                                        }
                                       
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right").bold().foregroundColor(.white)
                                }.padding(.bottom)
                            }
                        }
                    }
                }
            }
            .padding()
            .task {
                let result = await viewModel.getEmployees()
            }
        }
    }
}

#Preview {
    EmployeeListView().preferredColorScheme(.dark)
}
