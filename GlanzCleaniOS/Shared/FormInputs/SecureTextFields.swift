//
//  SecureTextFields.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct SecureTextFieldComponent: View {
    @Binding var text:String
    var placeholder: String
    var img = "lock.fill"
    
    var body: some View {
        HStack() {
            SecureField(placeholder, text: $text)
                .font(.custom("Poppins-Regular", size: 18))
                .padding()
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "person.fill")
                .padding(.horizontal)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(.white)
        .cornerRadius(28)
        .shadow(radius: 2)
    }
}

struct SecureTextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextFieldComponent(text: .constant(""), placeholder: "Enter your password")
    }
}
