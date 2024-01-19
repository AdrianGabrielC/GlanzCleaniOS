//
//  NotificationsView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    
    @ViewBuilder
    func Notification() -> some View {
        NavigationLink {
            WorkDetailsView(id: UUID().uuidString, customerName: "Garanti", pending: true)
        }label: {
            HStack {
                Image("NotificationImg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("John Doe added a new work!")
                    .font(.custom("Poppins-Bold", size: 16))
                Image(systemName: "chevron.right").bold()
            }.foregroundStyle(.white)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                VStack(alignment:.leading) {
                    Text("Today").font(.custom("Poppins-Bold", size: 22)).padding(.leading)
                    Notification()
                    Notification()
                }.padding(.vertical)
                VStack(alignment:.leading) {
                    Text("Yesterday").font(.custom("Poppins-Bold", size: 22)).padding(.leading)
                    Notification()
                }.padding(.vertical)
                VStack(alignment:.leading) {
                    Text("30 Dec, 2023").font(.custom("Poppins-Bold", size: 22)).padding(.leading)
                    Notification()
                }.padding(.vertical)
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Notifications") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
}

#Preview {
    NotificationsView()
}
