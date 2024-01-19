//
//  CalendarView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct CalendarView: View {
    @State var selectedView: CalendarTypeEnum = .list
    //@EnvironmentObject var toastManager: ToastManager
    @StateObject var calendarManager: CalendarViewModel = CalendarViewModel()
    @State var selectedYear = Calendar.current.component(.year, from: Date())
    @State var selectedMonth:Int = Calendar.current.component(.month, from: Date())
    @State var selectedDay = ""
    

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Text("Calendar")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Bold", size: 28))
                            .padding(.leading, 5)
                        Spacer()
                        
                    }
                    CalendarHeaderComponent(selectedView: $selectedView, selectedYear: $selectedYear, selectedMonth: $selectedMonth, selectedDay: $selectedDay)
                        //.environmentObject(toastManager)
                        .environmentObject(calendarManager)
                        .overlay(
                            Circle()
                                .fill(Color("MainYellow"))
                                .frame(width: 150)
                                .offset(x: 200, y: -110)
                        )
                    if selectedView == .day {
                        CalendarDayComponent(selectedYear: $selectedYear, selectedMonth: $selectedMonth)
                            .environmentObject(calendarManager)
                    }
                    else if selectedView == .month {
                        CalendarMonthComponent(selectedYear: $selectedYear, selectedMonth: $selectedMonth)
                            .environmentObject(calendarManager)
                            .padding(.top)
                    }
                    else {
                        CalendarListComponent(selectedMonth: $selectedMonth)
                            .environmentObject(calendarManager)
                            .padding(.top)
                    }
                    Spacer()
                }
                //.disabled(isLoading)
//                if isLoading {
//                    LoadingView(loadingType: .download).brightness(0.5)
//                }
            }
            //.brightness(isLoading ? -0.5 : 0)
            .task {
                var result = await calendarManager.getWork(year:selectedYear, month: selectedMonth, day: Int(selectedDay))
            }
        }
    
    }
}

#Preview {
    CalendarView().preferredColorScheme(.dark)
}
