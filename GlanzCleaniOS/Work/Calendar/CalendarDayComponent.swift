//
//  CalendarDayComponent.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct WorkInterval: Identifiable {
    var id = UUID().uuidString
    var start: Int
    var end: Int
}

struct CalendarDayComponent: View {
    @EnvironmentObject var calendarManager: CalendarViewModel
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @State var selectedDay = 3
    @State var daysInMonth = 0
    
    var workIntervals: [WorkInterval] = [.init(start: 13, end: 18),
                                         .init(start: 7, end: 13),
                                         .init(start: 16, end: 20),
                                         .init(start: 9, end: 12)]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1..<daysInMonth+1, id:\.self) { day in
                        HStack(alignment: .top) {
                            Button {
                                withAnimation {
                                    selectedDay = day
                                }
                            } label: {
                                VStack {
                                    Text("\(day)").foregroundColor(selectedDay == day ? .black : .white)
                                    if let dayOfWeek = calendarManager.getAbbreviatedDayOfWeek(year: selectedYear, month: selectedMonth, day: day) {
                                        Text("\(dayOfWeek)").foregroundColor(selectedDay == day ? .black : .gray) .font(.custom("Poppins-Regular", size: 14))
                                    }
                                }
                                .font(.custom("Poppins-Regular", size: 14))
                                .padding(5)
                                .frame(width:40)
                                //.background(selectedDay == day ? Color(red: 18/255, green: 18/255, blue: 18/255) : .black)
                                .background(selectedDay == day ? Color("MainYellow") : .black)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            }
                        }.frame(height: 60)
                    }.padding(.bottom)
                }
            }
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
                
            }
        }
        .onAppear {
            daysInMonth = calendarManager.getDaysInMonth(selectedMonth) ?? 0
        }
        .onChange(of: selectedMonth) { newValue in
            daysInMonth = calendarManager.getDaysInMonth(selectedMonth) ?? 0
        }

    }
}

struct CalendarDayComponent_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDayComponent(selectedYear: .constant(1), selectedMonth: .constant(1)).environmentObject(CalendarViewModel())
    }
}

struct DayWorkView: View {
    let height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Windows").font(.custom("Poppins-Regular", size: 12))
            Text("BRD Hall").font(.custom("Poppins-Regular", size: 12))
            Spacer()
            HStack{
                Image(systemName: "clock")
                Text("7:00 - 11:00")
            }.font(.custom("Poppins-Regular", size: 10))
        }
        .padding(5)
        .foregroundColor(Color(red: 17/101, green: 56/255, blue: 24/255))
        .bold()
        .frame(width: 100, height:height, alignment: .topLeading)
        .background(.green)
        .cornerRadius(5)
        .font(.custom("Poppins-Regular", size: 12))
    }
}
