//
//  ForgotPassStepTwo.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct ForgotPassStepTwo: View {
    @Environment(\.dismiss) var dismiss
    @State var cbOneValid = false
    @State var cbTwoValid = false
    @State var cbThreeValid = false
    
    @State var password = "" {
        didSet {
            cbOneValid = password.count > 6
            cbTwoValid = password.contains(where: {$0.isUppercase})
            cbThreeValid = password.contains(where: {$0.isNumber})
        }
    }
    @State var confirm_password = ""
    
    var body: some View {
        ZStack(alignment:.topLeading) {
            Color("MainYellow").ignoresSafeArea()
            Circle()
                .fill(.black)
                .frame(width: 250)
                .offset(x: -120, y: 0)
                
            VStack(alignment:.leading) {
                HStack {
                    Spacer()
                    VStack {
                        Image("RegisterStepThreeImg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125)
                        HStack(spacing:0) {
                            Text("Step two")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Bold", size: 14))
                                .padding(.trailing, 10)
                            Circle()
                                .fill(.black)
                                .frame(width: 10)
                            Rectangle()
                                .fill(.black)
                                .frame(width: 15, height: 2)
                            Circle()
                                .fill(.black)
                                .frame(width: 10)
                     
                        }
                        Text("Account recovery")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Bold", size: 24))
                      
                    }.padding(.horizontal, 35).padding(.top, 50).padding(.bottom, 50)
                }
                
                ScrollView {
                    VStack(alignment: .leading, content: {
                        // PASSWORD
                        HStack {
                            Image(systemName: "lock.fill")
                            Text("New Password")
                        }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
                        SecureTextFieldComponent(text: $confirm_password, placeholder: "Enter your password")
                            .padding(.bottom, 5)
                        VStack(alignment:.leading) {
                            Checkbox(isValid: cbOneValid, text: "At least 6 characters long")
                            Checkbox(isValid: cbTwoValid, text: "At least one upper case character")
                            Checkbox(isValid: cbThreeValid, text: "At least one digit")
                            
                        }.padding(.horizontal).padding(.bottom)
                        // CONFIRM PASS
                        HStack {
                            Image(systemName: "lock.fill")
                            Text("Confirm New Password")
                        }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
                        if !password.isEmpty && !confirm_password.isEmpty && password != confirm_password {
                            Text("Passwords don't match")
                                .font(.custom("Poppins-SemiBold", size: 14))
                                .foregroundStyle(.red)
                                .padding(.leading)
                        }
                        SecureTextFieldComponent(text: $confirm_password,placeholder: "Confirm your password")
                            .padding(.bottom)
                      
                        Spacer()
                        Button {
                            
                        }label: {
                            Text("Change password")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(.black)
                                .cornerRadius(28)
                                .padding(.top)
                        }
                    })
                }
                .scrollIndicators(.hidden)
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
                        Text("Forgot password") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color(.black))
                }
        )
    }
    @ViewBuilder
    func Checkbox(isValid: Bool, text:String) -> some View {
        HStack {
            if isValid {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .frame(width:25, height:25)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color(red: 87/255, green: 154/255, blue: 89/255))
                    )
                Text(text)
                    .foregroundStyle(Color(red: 87/255, green: 154/255, blue: 89/255))
            }
            else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .frame(width:25, height:25)
                    .overlay(
                        Image(systemName: "multiply").foregroundStyle(.red)
                    )
                Text(text).foregroundStyle(.red)
            }
        }.font(.custom("Poppins-SemiBold", size: 14))
    }

}

#Preview {
    ForgotPassStepTwo()
}
