//
//  RegisterStepOne.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct RegisterStepOne: View {
    @Environment(\.dismiss) var dismiss
    @State var text = ""
    
    var body: some View {
        ZStack(alignment:.topLeading) {
            Color("MainYellow").ignoresSafeArea()
            
            Circle()
                .fill(.black)
                .offset(x: 250, y: 0)
                
            VStack(alignment:.leading) {
                VStack {
                    Image("RegisterStepOneImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    HStack(spacing:0) {
                        Text("Step one")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Bold", size: 14))
                            .padding(.trailing, 10)
                        Circle()
                            .fill(.black)
                            .frame(width: 10)
                        Rectangle()
                            .fill(.white)
                            .frame(width: 15, height: 2)
                        Circle()
                            .fill(.white)
                            .frame(width: 10)
                        Rectangle()
                            .fill(.white)
                            .frame(width: 15, height: 2)
                        Circle()
                            .fill(.white)
                            .frame(width: 10)
                    }
                    Text("Credentials")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 24))
                }.padding(.horizontal, 35).padding(.top, 50).padding(.bottom, 50)
                
                // EMAIL
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("Email")
                }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
               AuthTextFieldComponent(text: $text, placeholder: "Enter your email")
                    .padding(.bottom, 25)
                
                // PASSWORD
                HStack {
                    Image(systemName: "lock.fill")
                    Text("Password")
                }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
                SecureTextFieldComponent(text: $text, placeholder: "Enter your password")
                    .padding(.bottom, 25)
                
                // CONFIRM PASS
                HStack {
                    Image(systemName: "lock.fill")
                    Text("Confirm Password")
                }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
                SecureTextFieldComponent(text: $text,placeholder: "Confirm your password")
                    .padding(.bottom)
                Spacer()
                
                NavigationLink {
                    RegisterStepTwo()
                }label: {
                    Text("Continue")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.black)
                        .cornerRadius(28)
                }
                
            }
            
        .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Register") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color(.black))
                }
        )
    }
}

struct RegisterStepOne_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStepOne()
    }
}
