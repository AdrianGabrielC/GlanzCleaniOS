//
//  BlueButton.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct BlueButton: View {
    var width: CGFloat?
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        }label: {
            Text(text)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(.black)
        }
        .frame(maxWidth: width != nil ? width : .infinity, maxHeight: 50)
        .background(.blue.gradient)
        .cornerRadius(10)
    }
}

struct BlueButton_Previews: PreviewProvider {
    static var previews: some View {
        BlueButton(text: "", action: {})
    }
}
