//
//  MyAccountView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct MyAccountView: View {
    @Environment(\.dismiss) var dismiss
    @State var email = "john@doe.com"
    @State var phone = "0750123456"
    @State var address = "Mecklenburg-Vorpommern, Altwigshagen, Feldstrasse 44"
    
    
    var body: some View {
        VStack(alignment:.center) {
            Image("ProfileImg")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text("John Doe")
                .font(.custom("Poppins-SemiBold", size: 22))
                .padding(.bottom, 40)
            HStack {
                Image(systemName: "envelope.fill")
                Text("Email")
                Spacer()
                TextField("Enter email", text:$email)
                    .frame(maxWidth: 250)
                    .multilineTextAlignment(.trailing)
            }.padding(.bottom)
            HStack {
                Image(systemName: "phone.fill")
                Text("Phone")
                Spacer()
                TextField("Enter phone", text:$phone)
                    .frame(maxWidth: 250)
                    .multilineTextAlignment(.trailing)
            }.padding(.bottom)
            HStack {
                Image(systemName: "phone.fill")
                Text("Address")
                Spacer()
                TextField("Enter address", text:$address)
                    .frame(maxWidth: 250)
                    .multilineTextAlignment(.trailing)
            }.padding(.bottom)
            Spacer()
            Button{
                
            }label: {
                Text("Update")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("MainColor"))
                    .padding(.bottom)
            }.buttonStyle(.plain)
        }
        .font(.custom("Poppins-SemiBold", size: 16))
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("My account") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
}

#Preview {
    MyAccountView()
}
