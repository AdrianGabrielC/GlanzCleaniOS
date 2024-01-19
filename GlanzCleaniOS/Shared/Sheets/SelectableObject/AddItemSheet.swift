//
//  AddItemSheet.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import SwiftUI

struct AddItemSheet<ViewModel:SelectableObjectsProvider>: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var toast: Toast?
    var title:String
    var inputName: String
    var inputImg: String
    var inputPlaceholder: String
    @Binding var navigation: Bool
    @State var itemName: String = ""
    var type: SelectableObjectType
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Rectangle().fill(Color("MainColor")).frame(height:30)
                    HStack {
                        Button{
                            navigation = false
                        }label:{
                            Image(systemName: "chevron.left").padding(.leading).foregroundStyle(.white).bold()
                        }
                        Spacer()
                    }
                    Text(title)
                }
                .padding(.bottom)
                
                EmployeeDetailsFormInput(icon: inputImg,
                                         inputName: inputName,
                                         placeholder: inputPlaceholder,
                                         input: $itemName,
                                         isInputValid: true,
                                         errInfo:"")
                .padding()
                Spacer()
                Button {
                    Task {
                        viewModel.newSelectableObject = SelectableObject(id: UUID().uuidString, name: itemName, selected: false)
                        isLoading = true
                        let result = await viewModel.addItem(type: type)
                        isLoading = false
                        var toastSuccessMessage = type == .customer ? "Customer successfully added!" : type == .facility ? "Facility successfully added!" : "Operation successfully added!"
                        var toastFailureMessage = type == .customer ? "Failed to add customer!" : type == .facility ? "Failed to add facility!" : "Failed to add operation"
                        toast = Toast(style: result == .Success ? .success : .error, message: result == .Success ? toastSuccessMessage : toastFailureMessage )
                        navigation = false
                    }
                    
                } label :{
                    Text("Save")
                        .frame(maxWidth:.infinity, maxHeight: 40)
                        .background(Color("MainYellow"))
                        //.cornerRadius(10)
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 40)
                .disabled(!itemName.isEmpty ? false : true)
                .opacity(!itemName.isEmpty ? 1 : 0.5)
                .padding()
                
            }
            .navigationBarHidden(true) // Hide the navigation bar
            .navigationBarBackButtonHidden(true) // Hide the back button
            .font(.custom("Poppins-SemiBold", size: 16))
            .background(Color(red: 19/255, green: 21/255, blue: 27/255))
            .disabled(isLoading)
            if isLoading {
                LoadingView(loadingType: .upload)
            }
        }

    }
}

#Preview {
    AddItemSheet(viewModel: AddWorkViewModel(), toast: .constant(Toast(style: .error, message: "")), title: "", inputName: "", inputImg: "", inputPlaceholder: "", navigation: .constant(false), type: .customer).preferredColorScheme(.dark)
}
