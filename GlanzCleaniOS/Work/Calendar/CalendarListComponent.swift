//
//  CalendarListComponent.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct CalendarListComponent: View {
    @EnvironmentObject var calendarManager: CalendarViewModel
    @Binding var selectedMonth: Int

    
    var body: some View {
        ScrollView {
            if calendarManager.work.isEmpty {
                Image("NoDataImg")
                    .resizable()
                    .scaledToFit()
                    .padding()
                HStack{
                    Spacer()
                    Text("No work found!").font(.custom("Poppins-Bold", size: 24)).foregroundColor(.gray).padding()
                    Spacer()
                }
            }
            else {
//                ForEach(calendarManager.work.filter { calendarManager.getMonthIntFromDateString($0.date ?? "") == selectedMonth}) { work in
                ForEach(calendarManager.work.indices, id: \.self) { index in
                    NavigationLink {
                        WorkDetailsView(id: calendarManager.work[index].id , customerName: "ASD")
                    } label: {
                        HStack {
                            Image(calendarManager.work[index].status.lowercased() == "done" ? "WorkDone" : calendarManager.work[index].status.lowercased() == "canceled" ? "WorkCancelled" : calendarManager.work[index].status.lowercased() == "booked" ? "WorkBooked" : calendarManager.work[index].status.lowercased() == "in progress" ? "WorkInProgressV2" : "")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 50)
                            
                            // STATUS AND DATE
                            VStack(alignment: .leading, spacing: 10) {
                                Text(calendarManager.work[index].status ).foregroundColor(calendarManager.work[index].status.lowercased() == "done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : calendarManager.work[index].status == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : calendarManager.work[index].status == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : calendarManager.work[index].status == "Booked" ? Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                
                                Text("\(calendarManager.work[index].dateStartTime)")
                                    .font(.custom("Poppins-Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                            
                            // LOCATION AND SERVICE
                            Spacer()
                            VStack(alignment: .center, spacing: 10) {
                                Text(calendarManager.work[index].customer.name).foregroundStyle(Color(red: 200/255, green: 215/255, blue: 215/255))
                                Text(calendarManager.work[index].operation.name).foregroundColor(.gray).font(.custom("Poppins-Bold", size: 12))
                            }
                            
                            // INCOME AND ACCEPTED
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text("€ \(calendarManager.getDoubleFromDecimal(value: calendarManager.work[index].totalIncome), specifier: "%.2f")").foregroundColor(calendarManager.work[index].status.lowercased() == "done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : calendarManager.work[index].status == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : calendarManager.work[index].status == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : calendarManager.work[index].status == "Booked" ? Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                
                                if calendarManager.work[index].status.lowercased() != "pending"  {
                                    Image(systemName: "checkmark").foregroundColor(.green).bold()
                                } else {
                                    Image(systemName: "multiply").foregroundColor(.red).bold()
                                }
                            }
                        }
                        .frame(height: 50)
                        .fontWeight(.semibold)
                        .font(.custom("Poppins-Bold", size: 14))
                        .padding(.vertical, 5)
                    }
                    Divider()
                }
                .padding(.leading, 20)
            }
            
        }
        .listStyle(.plain)
    }
}

struct CalendarListComponent_Previews: PreviewProvider {
    static var previews: some View {
        CalendarListComponent( selectedMonth: .constant(1)).environmentObject(CalendarViewModel())
    }
}
