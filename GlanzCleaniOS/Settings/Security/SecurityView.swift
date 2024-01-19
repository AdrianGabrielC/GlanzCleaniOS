//
//  SecurityView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct SecurityView: View {
    @Environment(\.dismiss) var dismiss
    @State var bioOn = true
    @State var showDeleteAccAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                MenuItem(img: "BioImg", title: "Biometrics", toggle : true )
                NavigationLink {
                    ChangeQAView()
                }label: {
                    MenuItem(img: "QAImg", title: "Change security questions")
                }
                Button {
                    showDeleteAccAlert = true 
                }label:{
                    MenuItem(img: "DeleteAcc", title: "Delete Account", color:.pink)
                }
                .alert("Are you sure you want to delete your account?", isPresented: $showDeleteAccAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("OK", role: .destructive) { }
                    }
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Security") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
    
    @ViewBuilder
    func MenuItem(img:String, title:String, toggle:Bool = false, color:Color = .white) -> some View {
        HStack {
            Image(img)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            Text(title).font(.custom("Poppins-Bold", size: 16)).foregroundStyle(color)
            Spacer()
            if toggle {
                Toggle("", isOn: $bioOn).padding(.trailing).tint(Color("MainColor"))
            }else {
                Image(systemName: "chevron.right").bold().foregroundStyle(color)
            }
        }
    }
}

#Preview {
    SecurityView().preferredColorScheme(.dark)
}
