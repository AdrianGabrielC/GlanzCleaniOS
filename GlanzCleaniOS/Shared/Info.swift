//
//  Info.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
import SwiftUI


struct Info: View {
    var text: String
    
    var body: some View {
        HStack {
            Circle().fill(Color("MainColor")).frame(width: 20, height: 20)
                .overlay(
                    Text("!").bold()
                )
            Text(text).font(.footnote)
        }
    }
}
