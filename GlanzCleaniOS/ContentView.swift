//
//  ContentView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @State var employees: [String] = []
    @StateObject var serviceManager = ServiceManager()
    @ObservedObject var viewModel = ContentViewModel.shared
    
    var body: some View {
        if viewModel.isLogged {
            NavigationStack {
                TabView {
//                    test()
//                        .tabItem {
//                            Image(systemName:"person")
//                            Text("ASDSA")
//                        }
                    EmployeeListView()
                        .tabItem {
                            Image(systemName: "person.3")
                            Text("Employees")
                        }
                    CalendarView()
                        .tabItem {
                            Image(systemName: "briefcase.fill")
                            Text("Work")
                        }
                    InvoiceListView()
                        .tabItem {
                            Image(systemName: "newspaper")
                            Text("Invoices")
                        }
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                }.tint(Color("MainColor"))
            }
        }
        else {
            NavigationStack{
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
