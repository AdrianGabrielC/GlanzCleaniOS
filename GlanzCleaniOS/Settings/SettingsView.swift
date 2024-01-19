//
//  SettingsView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID().uuidString
    var text: String
    var img: String
    var textColor: Color = .white
    var imgColor: Color = .white
}


struct SettingsView: View {
    @State var showLogoutAlert = false 
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading, spacing: 30) {
                HStack(alignment:.top) {
                    Text("Settings").font(.custom("Poppins-Bold", size: 28)).padding(.trailing, 40)
                    Spacer()
                    Image("SettingsImg")
                        .resizable()
                        .scaledToFit()
                }.padding(.bottom)
             
                NavigationLink{
                    MyAccountView()
                }label:{
                    MenuItem(img: "MyProfileImg", title: "My account")
                }
                NavigationLink{
                    SecurityView()
                }label:{
                    MenuItem(img: "SecurityImg", title: "Security")
                }
                NavigationLink{
                    TaxView()
                }label:{
                    MenuItem(img: "TaxImg", title: "Tax")
                }
                NavigationLink{
                    LanguageView()
                }label:{
                    MenuItem(img: "LanguageImg", title: "Language")
                }
                NavigationLink{
                    ReportAnIssueView()
                }label:{
                    MenuItem(img: "ReportAnIssueImg", title: "Report an issue")
                }
                Button{
                    showLogoutAlert = true
                }label:{
                    HStack(alignment:.center) {
                        Image("LogOutImg")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 80, maxHeight: 80)
                            .padding(.trailing)
                        Text("Log out").font(.custom("Poppins-Bold", size: 16)).foregroundStyle(.pink)
                        Spacer()
                        Image(systemName: "chevron.right").bold().foregroundStyle(.pink)
                    }.foregroundColor(.white)
                }
                .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Yes", role: .destructive) { ContentViewModel.shared.logout() }
                    }
            }
            .font(.custom("Poppins-Bold", size: 16))

        }
        .padding()
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func MenuItem(img:String, title:String) -> some View {
        HStack(alignment:.center) {
            Image(img)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80, maxHeight: 80)
                .padding(.trailing)
            Text(title).font(.custom("Poppins-Bold", size: 16))
            Spacer()
            Image(systemName: "chevron.right").bold()
        }.foregroundColor(.white)
    }
}

#Preview {
    SettingsView()
}
