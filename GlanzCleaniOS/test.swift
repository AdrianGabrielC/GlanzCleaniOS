//
//  test.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import SwiftUI

struct test: View {
    @State private var toast: Toast? = nil
    
    @State var price = 1.0
    
    
    @State var field: Double = 0.0
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    var body: some View {
      VStack(spacing: 10) {
          HStack {
              Image("ProfileImg")
                  .resizable()
                  .scaledToFit()
                  .frame(width:40)
              VStack(alignment:.leading, spacing:1) {
                  Text("John Doe")
                      .font(.custom("Poppins-Bold", size: 16))
                      .foregroundColor(.white)
                  HStack(spacing: 3){
                      Circle().fill(.green).frame(width: 10)
                      Text("Active").font(.custom("Poppins-Bold", size: 12))
                      .foregroundColor(.green)
                  }
              }
              
//              HStack {
//                  Text("placeHolder")
//                  Spacer()
//                  TextField("$0.00", value: $field, formatter: formatter)
//                      .textFieldStyle(RoundedBorderTextFieldStyle())
//                      .keyboardType(.numberPad)
//                      .frame(width: 100)
//                      .textFieldStyle(.roundedBorder)
//              }
//              .padding(8)
//              .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
     

              Spacer()
              Text("$25").foregroundStyle(.green).font(.custom("Poppins-Regular", size: 22))

          }
          VStack(spacing: 0) {
              Slider(value: $price, in: 1...50, step: 0.5).tint(.green)
          }
//        Button {
//          toast = Toast(style: .success, message: "Saved.")
//        } label: {
//          Text("Run (Success)")
//        }
//        
//        Button {
//          toast = Toast(style: .info, message: "Btw, you are a good person.")
//        } label: {
//          Text("Run (Info)")
//        }
//        
//        Button {
//          toast = Toast(style: .warning, message: "Beware of a dog!")
//        } label: {
//          Text("Run (Warning)")
//        }
//        
//        Button {
//          toast = Toast(style: .error, message: "Fatal error, blue screen level.")
//        } label: {
//          Text("Run (Error)")
//        }
//        
      }
      .toastView(toast: $toast)
    }
}

#Preview {
    test().preferredColorScheme(.dark)
}













