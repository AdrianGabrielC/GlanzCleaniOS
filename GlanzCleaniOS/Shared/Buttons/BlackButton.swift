//
//  BlackButton.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct BlackButton: View {
    var width: CGFloat?
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        }label: {
            Text(text)
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(.white)
        }
        .frame(maxWidth: width != nil ? width : .infinity)
        .frame(height: 50)
        .background(.black)
        .cornerRadius(28)
    }
}

struct BlackButton_Previews: PreviewProvider {
    static var previews: some View {
        BlackButton(text: "Submit", action: {})
    }
}
