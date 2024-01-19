//
//  WorkDetailsView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct WorkMenuItem: View {
    var img: String
    var placeholder: String
    var value: String
    var valueColor: Color = .white
    
    var body: some View {
        HStack{
            Image(systemName: img).foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
            Text(placeholder).foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
            Spacer()
            Text(value).bold().foregroundStyle(valueColor)
        }
    }
}


struct WorkDetailsView: View {
    //@EnvironmentObject var toastManager: ToastManager
    var id: String
    var customerName: String
    @State var object: GET.Work?
    @Environment(\.dismiss) var dismiss
    @State var isLoading = false
    
    // ALERTS
    @State var showRemoveAlert = false // used to remove an existing work
    @State var showDenyAlert = false // used to deny a work added by an employee
    @State var showConfirmAlert = false // used to confirm a work added by an employee
    // STATES
    @State var pending = false // Used to confirm a work added by an employee
    
    // TEST
    var workStatus = "done"
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
//                        Image(object?.workStatus?.lowercased() == "done" ? "WorkDone" : object?.workStatus == "Canceled" ? "WorkCancelled" : object?.workStatus == "Booked" ? "WorkBooked" : object?.workStatus == "In Progress" ? "WorkInProgressV2" : "")
                        Image("WorkDone")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding(.bottom)
                        Circle()
                            .fill(Color("MainYellow"))
                            .frame(width: 140, height: 140)
                            .offset(x: 70, y: -40)
                    }
                    HStack {
                        Spacer()
                        HeaderBtn(img: "pencil") {
                            
                        }
                        if pending {
                            HeaderBtn(img: "checkmark", imgColor: .green) {
                                showConfirmAlert = true
                            }
                            .alert("Are you sure you want to confirm this work?", isPresented: $showConfirmAlert) {
                                Button("Cancel", role: .cancel) { }
                                Button("OK", role: .none) { }.tint(.green)
                                }
                            HeaderBtn(img: "multiply", imgColor: .red) {
                                showDenyAlert = true
                            }
                            .alert("Are you sure you want to deny this work?", isPresented: $showDenyAlert) {
                                Button("Cancel", role: .cancel) { }
                                Button("OK", role: .destructive) { }
                                }
                        }
                        if !pending {
                            HeaderBtn(img: "newspaper.fill") {
                                
                            }
                            HeaderBtn(img: "trash", imgColor: .red) {
                                showRemoveAlert = true
                            }
                            .alert("Are you sure you want to delete this work?", isPresented: $showRemoveAlert) {
                                Button("Cancel", role: .cancel) { }
                                Button("OK", role: .destructive) { }
                                }
                        }
                     
                      
                       
                    }.padding(.bottom, 20)
                    
                    VStack(alignment:.leading, spacing: 10) {
                        Group {
                            Text("DETAILS")
                                .font(.custom("Poppins-Bold", size: 18))
                                .padding(.leading, 25)
                                .foregroundStyle(.white)
                            DetailsItem(img: workStatus == "done" ? "checkmark" :
                                            workStatus == "canceled" ? "multiply" :
                                            workStatus == "pending" ? "clock" : "calendar",
                                        title: "Status",
                                        value: workStatus == "done" ? "Done" :
                                            workStatus == "canceled" ? "Canceled":
                                            workStatus == "pending" ? "Pending" : "Booked",
                            color: workStatus == "done" ? .green :
                                            workStatus == "canceled" ? .red :
                                            workStatus == "pending" ? .blue : .white)
                            DetailsItem(img: "person.fill", title: "Customer", value: "Design Studio")
                            DetailsItem(img: "building.fill", title: "Facility", value: "Headquarters")
                            DetailsItem(img: "mappin", title: "Address", value: " 789 Creative Lane, Bucharest")
                            DetailsItem(img: "briefcase.fill", title: "Service", value: "General cleaning")
                                .padding(.bottom, 30)
                        }
                        
                        Group {
                            Text("Date and time")
                                .font(.custom("Poppins-Bold", size: 18))
                                .padding(.leading, 25)
                                .foregroundStyle(.white)
                            DetailsItem(img: "calendar", title: "Date", value: "20 Jan, 2024")
                            DetailsItem(img: "clock", title: "Start time", value: "08:00 AM")
                            DetailsItem(img: "stopwatch", title: "End time", value: "12:30 PM")
                            DetailsItem(img: "hourglass", title: "Hours worked", value: "4 hours")
                            DetailsItem(img: "cup.and.saucer.fill", title: "Work break", value: "30 minutes")
                                .padding(.bottom, 30)
                        }
                        
                        Group {
                            Text("Financials")
                                .font(.custom("Poppins-Bold", size: 18))
                                .padding(.leading, 25)
                                .foregroundStyle(.white)
                            DetailsItem(img: "timer", title: "Price per hour", value: "$100,00")
                            DetailsItem(img: "dollarsign.circle", title: "Income", value: "$400,00")
                            DetailsItem(img: "person.2.crop.square.stack", title: "Employee payment", value: "$200,00", color:.red)
                            DetailsItem(img: "arrow.up.circle", title: "Profit", value: "$200,00", color:.green)
                                .padding(.bottom, 30)
                        }
                        
                        Group {
                            Text("Employees")
                                .font(.custom("Poppins-Bold", size: 18))
                                .padding(.leading, 25)
                                .foregroundStyle(.white)
                            EmployeesSection(employees: [.init(name: "John Doe", payment: 50.0), .init(name: "Daniel Smith", payment: 50.0), .init(name: "James Taylor", payment: 100.0)])
                        }
                    }
                  
                 
                    
                }.padding()
            }
            .disabled(isLoading)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button {
                       dismiss()
                    }label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill").font(.title)
                            Text("Work details") .font(.custom("Poppins-Bold", size: 24))
                        }.foregroundColor(Color("MainYellow"))
                    }
            )
//            .task {
//                isLoading = true
//                WorkService.shared.getWorkDetails(id: id) { workDetails, response in
//                    switch response.status {
//                    case .success:
//                        self.object = workDetails
//                        isLoading = false
//                    case .failure:
//                        dismiss()
//                        toastManager.showToast(type: .failure, message: "Failed to get work details!")
//                    }
//                }
//            }
            if isLoading {
                LoadingView(loadingType: .download).brightness(0.5)
            }
        }.brightness(isLoading ? -0.5 : 0)
    }
    
   @ViewBuilder
    func DetailsItem(img: String, title:String, value:String, color:Color = .white) -> some View  {
        HStack {
            Image(systemName: img)
            .foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
            .bold()
            .frame(width: 20)
            Text(title).foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
            Spacer()
            Text(value)
            .foregroundStyle(color)
            
        }.font(.custom("Poppins-SemiBold", size: 16))
    }


    
    @ViewBuilder
    func EmployeesSection(employees: [Employee]) -> some View {
        VStack(spacing: 0){
            ForEach(employees) { employee in
                HStack {
                    Image("ProfileImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width:25)
                    VStack(alignment:.leading, spacing: 0) {
                        Text(employee.name)
                            .font(.custom("Poppins-Bold", size: 16))
                            .foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
                        HStack(spacing: 3){
                            Circle().fill(.green).frame(width: 10)
                            Text("Active").font(.custom("Poppins-Bold", size: 12)).foregroundColor(.green)
                        }
                    }
                    Spacer()
                    Text("$\(employee.payment, specifier: "%.2f")").foregroundStyle(.red)
                }.padding(.bottom)
            }
        }
        .font(.custom("Poppins-SemiBold", size: 16))
        //.padding()
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    @ViewBuilder
    func HeaderBtn(img:String, imgColor:Color = .white, action: @escaping () -> Void) -> some View {
        Button {
            action()
        }label: {
            Image(systemName: img)
                .frame(width:40, height:40)
                .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                .cornerRadius(10)
                .foregroundColor(imgColor)
        }
    }
    
    struct Employee: Identifiable {
        var id = UUID().uuidString
        var name: String
        var payment: Double
    }
}

struct WorkDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkDetailsView(id: UUID().uuidString, customerName: "Andrew")
    }
}
