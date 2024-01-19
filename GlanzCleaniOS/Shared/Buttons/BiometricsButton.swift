//
//  BiometricsButton.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct BiometricsButton: View {
    @State var faceId:Bool
    @State var touchId:Bool
    var width: CGFloat?
    
    var body: some View {
        Button {
            
        }label: {
            Image(systemName: faceId ? "faceid" : "touchid")
                .foregroundColor(.white)
            Text(faceId ? "Face ID" : "Touch ID")
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(.white)
        }
        .frame(maxWidth: width != nil ? width : .infinity, maxHeight: 50)
        .background(.black)
        .cornerRadius(28)
 
    }
}

struct BiometricsButton_Previews: PreviewProvider {
    static var previews: some View {
        BiometricsButton(faceId: false, touchId: true)
    }
}
