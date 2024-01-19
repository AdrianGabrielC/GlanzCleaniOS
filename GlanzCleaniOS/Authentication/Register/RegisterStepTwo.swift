//
//  RegisterStepTwo.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct RegisterStepTwo: View {
    @Environment(\.dismiss) var dismiss
    @State private var birthDate = Date.now
    @State var text = ""
    
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
                        Image("RegisterStepTwoImg")
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
                            Rectangle()
                                .fill(.white)
                                .frame(width: 15, height: 2)
                            Circle()
                                .fill(.white)
                                .frame(width: 10)
                        }
                        Text("Personal data")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Bold", size: 24))
                    }.padding(.horizontal, 35).padding(.top, 50).padding(.bottom, 50)
                }
                
                // FIRST NAME
                HStack {
                    Image(systemName: "person.fill")
                    Text("First name")
                }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
               AuthTextFieldComponent(text: $text, placeholder: "Enter your first name")
                    .padding(.bottom, 25)
                
                // LAST NAME
                HStack {
                    Image(systemName: "person.fill")
                    Text("Last name")
                }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
               AuthTextFieldComponent(text: $text, placeholder: "Enter your last name")
                    .padding(.bottom, 25)
                
                // PHONE
                HStack {
                    Image(systemName: "person.fill")
                    Text("Phone")
                }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
                AuthTextFieldComponent(text: $text, placeholder: "Enter your phone", img:"phone.fill")
                     .padding(.bottom, 25)
                // DATE
//                HStack {
//                    Image(systemName: "calendar.circle.fill")
//                    Text("Employment start date")
//                }.font(.custom("Poppins-Bold", size: 18)).padding(.leading)
//                HStack{
//                    Text("Enter start date").foregroundColor(Color(red: 204/255, green: 204/255, blue: 206/255))
//                        .font(.custom("Poppins-Regular", size: 18))
//                    Spacer()
//                    DatePicker(selection: $birthDate, displayedComponents: .date) {
//                        Text("").font(.custom("Poppins-Bold", size: 14))
//                    }
//                    .font(.custom("Poppins-Bold", size: 18))
//                    .padding(.leading)
//                }
//                .padding()
//                .background(.white)
//                .cornerRadius(28)
//                .frame(maxWidth: .infinity)
              
                Spacer()
                NavigationLink {
                    RegisterStepThree()
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

struct RegisterStepTwo_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStepTwo()
    }
}
