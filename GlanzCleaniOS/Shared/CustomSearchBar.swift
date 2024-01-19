//
//  CustomSearchBar.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Search", text: $text)
                .font(.custom("Poppins-Regular", size: 18))
        }
        .padding(7)
        .background(Color(red: 41/255, green: 41/255, blue: 48/255))
        .cornerRadius(50)
    }
}
