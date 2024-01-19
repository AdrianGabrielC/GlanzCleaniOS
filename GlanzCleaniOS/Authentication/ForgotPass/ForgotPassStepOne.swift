//
//  ForgotPassStepOne.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct ForgotPassStepOne: View {
    @Environment(\.dismiss) var dismiss
    @State var showFirstQA = false
    @State var showSecondQA = false
    @State var text = ""
    
    var body: some View {
        ZStack(alignment:.topLeading) {
            Color("MainYellow").ignoresSafeArea()
            
            Circle()
                .fill(.black)
                .offset(x: 250, y: 0)
                
            VStack(alignment:.leading) {
                VStack {
                    Image("RegisterStepThreeImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125)
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
                 
                    }
                    Text("Account recovery")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 24))
                }
                .padding(.horizontal, 35)
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                ScrollView{
                    VStack(alignment: .leading, content: {
                        // EMAIL
                        HStack {
                            Image(systemName: "envelope.fill")
                            Text("Email")
                        }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
                        AuthTextFieldComponent(text: $text, placeholder: "Enter your email")
                            .padding(.bottom)
              
                        // QA
                        Button {
                            showFirstQA = true
                        }label: {
                            HStack {
                                Text("What is the name of your best friend?")
                                    .font(.custom("Poppins-Bold", size: 16))
                                Spacer()
                                Image(systemName: "chevron.down").bold()
                            }
                        }.buttonStyle(.plain).padding(.top).padding(.horizontal)
                       AuthTextFieldComponent(text: $text, placeholder: "Ex. Adrian")
                            .padding(.bottom)
                        Button {
                            showSecondQA = true
                        }label :{
                            HStack {
                                Text("What is the name of your favorite artist?")
                                    .font(.custom("Poppins-Bold", size: 16))
                                Spacer()
                                Image(systemName: "chevron.down").bold()
                            }
                        }.buttonStyle(.plain).padding(.top).padding(.horizontal)
                       AuthTextFieldComponent(text: $text, placeholder: "Ex. Tina Turner")
                            .padding(.bottom)
                   
                        Spacer()
                        NavigationLink {
                            ForgotPassStepTwo()
                        }label: {
                            Text("Continue")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(.black)
                                .cornerRadius(28)
                                .padding(.vertical)
                        }
                    })
                }
                .scrollIndicators(.hidden)
                
            }
            .sheet(isPresented: $showFirstQA, content: {
                QAList().presentationDetents([.medium])
            })
            .sheet(isPresented: $showSecondQA, content: {
                QAList().presentationDetents([.medium])
            })
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
}

#Preview {
    ForgotPassStepOne()
}
