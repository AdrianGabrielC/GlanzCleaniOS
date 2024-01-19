//
//  ChangeQAView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct ChangeQAView: View {
    @Environment(\.dismiss) var dismiss
    @State var firstQA = "What is the name of your favorite artist?"
    @State var secondQA = "What is the name of your favorite food?"
    @State var firstQAAns = "Tina Turner"
    @State var secondQAAns = "Pizza"
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Choose questions and answers that are memorable to you but difficult for others to guess.These security questions will be used to verify your identity in case you forget your password.")
                .font(.custom("Poppins-SemiBold", size: 14))
                .foregroundStyle(.gray)
                .padding(.bottom, 40)
            SelectQA(sfSymbolName: "", title: firstQA, field: $firstQA)
            BlackTextFieldComponent(sfSymbolName: "", placeHolder: "", prompt: "", field: $firstQAAns, isValid: true, type: .textField)
                .padding(.bottom,40)
            
            SelectQA(sfSymbolName: "", title: secondQA, field: $secondQA)
            BlackTextFieldComponent(sfSymbolName: "", placeHolder: "", prompt: "", field: $secondQAAns, isValid: true, type: .textField)
            Spacer()
            YellowButton(text: "Save") {
                
            }
            .padding(.bottom, 40)
        }
        .font(.custom("Poppins-SemiBold", size: 16))
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Change security questions") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
    
}

#Preview {
    ChangeQAView()
}


struct SelectQA: View {
    let securityQuestions = [
        "What is the name of your favorite pet?",
        "In which city were you born?",
        "What is the name of your first school?",
        "What is your favorite movie?",
        "Who is your childhood hero?",
        "What is your mother's maiden name?",
        "What is your favorite vacation destination?",
        "What is the make and model of your first car?",
        "What is the name of your best childhood friend?",
        "In what year did you graduate from high school?"
    ]
    var sfSymbolName: String
    var title: String
    @Binding var field: String
    @State var show = false
    @State var searchText = ""

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                show = true
            }label: {
                HStack {
                    Text(title).multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "chevron.right")
                }.foregroundColor(.white)
            }
            .sheet(isPresented: $show) {
                VStack {
                    HStack {
                        CustomSearchBar(text: $searchText)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    List {
                        Section(header: Text("Security questions")) {
                            ForEach(securityQuestions.filter({searchText.isEmpty ? true : $0.contains(searchText)}), id:\.self) { qa in
                                Button {
                                    show = false
                                    field = qa
                                }label: {
                                    Text(qa)
                                }.buttonStyle(.plain)
                            }
                        }
                    }
                    .presentationDetents([.medium])
                }
            }
            .padding(8)
        }
    }
}
