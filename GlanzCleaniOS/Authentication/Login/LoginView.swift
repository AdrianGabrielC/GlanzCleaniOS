//
//  LoginView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct LoginView: View {
    @State var phone = ""
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack(alignment:.topLeading) {
            //Color(red: 68/255, green: 174/255, blue: 255/255).ignoresSafeArea()
            Color("MainYellow").ignoresSafeArea().brightness(viewModel.isLoading ? -0.5 : 0)
            Circle()
                .fill(.black)
                .offset(x: -100, y: -150)
            VStack(alignment:.leading) {
                VStack {
                    Text("Welcome back")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 18))
                    Text("Log In")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 46))
                }.padding(50).padding(.bottom, 70)
                
                AuthTextFieldComponent(text: $viewModel.email, placeholder: "Enter your email")
                    .padding(.bottom)
                SecureTextFieldComponent(text: $viewModel.password, placeholder: "Enter your password")
                    .padding(.bottom, viewModel.showErr ? 0 : 30)
                if viewModel.showErr {
                    Text("Incorect username or password!")
                        .foregroundColor(.red)
                        .font(.custom("Poppins-Semibold", size: 14))
                        .padding(.bottom, 30)
                        .padding(.leading)
                }
                BlackButton(text: "Log In"){
                    Task {
                        await viewModel.login()
                    }
                }
                    .padding(.bottom, 30)
//                HStack {
//                    Spacer()
//                    Text("New employee?")
//                        .font(.custom("Poppins-Regular", size: 14))
//                    NavigationLink {
//                        RegisterStepOne()
//                    }label: {
//                        Text("Create an account")
//                            .font(.custom("Poppins-Bold", size: 14))
//                            .foregroundStyle(.white)
//                    }
//                }.padding(.bottom,1)
//                HStack {
//                    Spacer()
//                    NavigationLink {
//                        ForgotPassStepOne()
//                    }label: {
//                        Text("Forgot your password?")
//                            .font(.custom("Poppins-Regular", size: 14))
//                            .bold()
//                            .foregroundStyle(.white)
//                    }
//                }.padding(.bottom, 30)
//                HStack {
//                    Spacer()
//                    BiometricsButton(faceId: true, touchId: false, width: 300)
//                    Spacer()
//                }
                
                Spacer()
                HStack {
                    Rectangle().fill(.black).frame(height:1)
                    Text("GlanzClean").font(.custom("Poppins-Regular", size: 14))
                    Rectangle().fill(.black).frame(height:1)
                        .overlay(
                            ZStack {
                                Capsule()
                                    .frame(width: 100, height: 200) // Adjust the size of the capsule
                                    .foregroundColor(.black)
                                
                            
                            }
                        )
                }
                
            }
            .padding()
            .brightness(viewModel.isLoading ? -0.5 : 0)
            .disabled(viewModel.isLoading)
            if viewModel.isLoading {
                Loading()
            }
        
        }
//        .task {
//            let admin = POST.Register(firstName: "Sorin", lastName: "Postelnicescu", password: "Parolamea1!", email: "info.glanzclean@gmail.com", phone: "0033778956150", address: "BadenBaden Am Kirchplatz 10115", isActive: true, roles: ["Admin"])
//            await viewModel.serviceManager.authenticationService.register(user: admin)
//            
//        }
    }
    
    @ViewBuilder
    func Loading() -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                LoadingView(loadingType: .general)
                Spacer()
            }
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
