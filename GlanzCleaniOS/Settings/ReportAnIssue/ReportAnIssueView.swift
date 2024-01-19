//
//  ReportAnIssueView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct ReportAnIssueView: View {
    @Environment(\.dismiss) var dismiss
    @State private var issue = "Enter your issue"

    
    var body: some View {
        VStack(alignment:.leading) {
            Text("We will help you as soon as you describe the problem in the paragraphs below.").font(.custom("Poppins-SemiBold", size: 14)).foregroundStyle(.gray).padding(.bottom)
            Text("Comments").font(.custom("Poppins-SemiBold", size: 16)).foregroundStyle(.white).padding(.leading)
            TextEditor(text: $issue)
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundStyle(.white)
                .padding(.leading)
                .padding()
                .overlay (
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 33/255, green: 33/255, blue: 33/255), lineWidth: 2)
                   )
                .frame(maxHeight: 400)
                .padding(.bottom, 40)
            YellowButton(text: "Send") {
                
            }
          
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
                        Text("Report an issue") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
}

#Preview {
    ReportAnIssueView().preferredColorScheme(.dark)
}
