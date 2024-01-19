//
//  LanguageView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct LanguageView: View {
    enum Languages:String {
        case ro = "Romanian"
        case de = "German"
        case en = "English"
    }
    
    @Environment(\.dismiss) var dismiss
    @State var selectedLanguage: Languages = .en
    
    @ViewBuilder
    func Language(language: Languages) -> some View {
        HStack {
            Text(language.rawValue).font(.custom("Poppins-Bold", size: 18))
            Spacer()
            if selectedLanguage == language {
                Circle()
                    .stroke(Color("MainColor"), lineWidth: 2)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle().fill(Color("MainColor")).frame(width:14, height:14)
                    )
            }
            else {
                Circle()
                    .stroke(Color("MainColor"), lineWidth: 2)
                    .frame(width: 20, height: 20)
            }
      
                
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Language(language: .ro).padding(.top, 40)
            Language(language: .en)
            Language(language: .de)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Language") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
}

#Preview {
    LanguageView().preferredColorScheme(.dark)
}
