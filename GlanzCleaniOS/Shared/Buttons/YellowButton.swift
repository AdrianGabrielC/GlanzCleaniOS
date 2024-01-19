//
//  YellowButton.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct YellowButton: View {
    var width: CGFloat?
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
        }label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color("MainColor"))
                .padding(.bottom)  
                .font(.custom("Poppins-SemiBold", size: 16))
        }.buttonStyle(.plain)
    }
}

struct YellowButton_Previews: PreviewProvider {
    static var previews: some View {
        YellowButton(text: "Submit", action: {})
    }
}
