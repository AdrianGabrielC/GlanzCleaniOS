//
//  EmployeeWorkView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct EmployeeWorkView: View {
    @State var showAlert = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EmployeeWorkViewModel
    
    init(employee: GET.Employee) {
        self._viewModel = StateObject(wrappedValue: EmployeeWorkViewModel(employee: employee))
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            HStack {
                Image("ProfileImg")
                    .resizable()
                    .frame(width:70, height:70)
                VStack(alignment:.leading, spacing: 0) {
                    HStack(spacing: 4) {
                        Text(viewModel.employee.firstName)
                        Text(viewModel.employee.lastName)
                    }
                    .font(.custom("Poppins-Bold", size: 18))
                    HStack {
                        Circle().frame(width:10, height:10)
                        Text(viewModel.employee.isActive ? "Active" : "Inactive")
                    }
                    .foregroundColor(viewModel.employee.isActive ? .green : .red)
                    .font(.custom("Poppins-Bold", size: 12))
                }
                Spacer()
            }.foregroundColor(.white)
            HStack(spacing: 10){
                Spacer()
                NavigationLink {
                    AddEmployeeView(employee: viewModel.employee)
                }label: {
                    Image(systemName: "pencil")
                        .font(.title2)
                        .frame(width:40, height:40)
                        .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                        .cornerRadius(10)
                }
                NavigationLink {
                    EmployeeStatsView()
                    
                }label: {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.title2)
                        .frame(width:40, height:40)
                        .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                        .cornerRadius(10)
                }
                Button {
                    showAlert = true
                }label: {
                    Image(systemName: "power")
                        .font(.title2)
                        .frame(width:40, height:40)
                        .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                        .cornerRadius(10)
                        .foregroundStyle(.red)
                }
                .alert("Are you sure you want to disable this employee?", isPresented: $showAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("OK", role: .destructive) { }
                    }
               
            }.foregroundColor(.white).padding(.bottom)
            
  
            CustomSearchBar(text: $viewModel.searchText)
            
            // WORK
            ScrollView {
                if let employeeWork = viewModel.employee.work, !employeeWork.isEmpty {
                    ForEach(employeeWork.indices, id:\.self) { index in
                        Button {
                            //Text("Work details")
                            print("Go to Work details")
                            //WorkDetailsView(id: work.id ?? UUID(), customerName: "ASD")
                        } label: {
                            HStack {
                                Image(employeeWork[index].status.lowercased() == "done" ? "WorkDone" : employeeWork[index].status.lowercased() == "canceled" ? "WorkCancelled" : employeeWork[index].status.lowercased() == "booked" ? "WorkBooked" : employeeWork[index].status.lowercased() == "in progress" ? "WorkInProgressV2" : "")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50)

                                // STTAUS AND DATE
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(employeeWork[index].status)
                                        .bold()
                                        .foregroundColor(employeeWork[index].status.lowercased() == "done" ? Color(red: 0/255, green: 191/255, blue: 120/255) :
                                                            employeeWork[index].status == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) :
                                                            employeeWork[index].status == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) :
                                                            employeeWork[index].status == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                    Text(employeeWork[index].dateStartTime.toString())
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(.gray)
                                }

                                // LOCATION AND SERVICE
                                Spacer()
                                VStack(alignment: .center, spacing: 10) {
                                    Text(employeeWork[index].customer.name)
                                    Text(employeeWork[index].operation.name)
                                }.foregroundColor(.gray)

                                // INCOME AND ACCEPTED
                                Spacer()
                                VStack(alignment: .trailing, spacing: 10) {
                                    Text("€ \(viewModel.getDoubleFromDecimal(value: employeeWork[index].totalIncome), specifier: "%.2f")")
                                        .bold()
                                        .foregroundColor(employeeWork[index].status.lowercased() == "done" ? Color(red: 0/255, green: 191/255, blue: 120/255) :
                                                            employeeWork[index].status == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) :
                                                            employeeWork[index].status == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) :
                                                            employeeWork[index].status == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                    if employeeWork[index].status.lowercased() != "pending" {
                                        Image(systemName: "checkmark").foregroundColor(.green).bold()
                                    }
                                    else {
                                        Image(systemName: "multiply").foregroundColor(.red).bold()
                                    }
                                }
                            }
                            .frame(height: 50)
                            .fontWeight(.semibold)
                            .font(.custom("Poppins-Bold", size: 14))
                            .padding(.vertical,5)
                        }
                        Divider()
                    }.padding(.leading, 20)
                }
                else {
                    Image("NoDataImg")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .padding(.top, 40)
                    HStack{
                        Spacer()
                        Text("No work found!")
                            .font(.custom("Poppins-Bold", size: 24))
                            .foregroundColor(.gray).padding()
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
            
            //CalendarListComponent(selectedMonth: <#Binding<String>#>)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Employee Details") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
        .padding()

    }
}

#Preview {
    EmployeeWorkView(employee: .init(id: UUID().uuidString, firstName: "", lastName: "", isActive: true, email: "", phone: "", address: "")).preferredColorScheme(.dark)
}
