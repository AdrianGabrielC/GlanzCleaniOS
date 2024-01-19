//
//  SelectItemSheet.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import SwiftUI



struct SelectItemSheet<ViewModel:SelectableObjectsProvider>: View {
    @State private var toast: Toast? = nil
    var title: String
    @ObservedObject var viewModel: ViewModel
    @Binding var showCurrentSheet: Bool
    @State var searchText = ""
    @State var navigateToAdd = false
    var allowMultipleSelections = false
    @State var isLoading = false
    
    // MARK: Add new item
    var canAddNewItem: Bool
    var addItemTitle: String = ""
    var addItemName: String = ""
    var addItemImg: String = ""
    var addItemPlaceholder: String = ""
    var type: SelectableObjectType
    
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle().fill(Color("MainColor")).frame(height:30)
                    Text(title)
                        
                }.padding(.bottom)
                
                HStack(spacing: 15) {
                    CustomSearchBar(text: $searchText)
                    if canAddNewItem {
                        Button {
                            navigateToAdd = true
                        }label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .frame(width:40, height:40)
                                .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                              
                        }
                    }
                    Button {
                       showCurrentSheet = false
                    }label: {
                        Image(systemName: "checkmark")
                            .font(.title2)
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                          
                    }
                }.padding(.horizontal).padding(.bottom)
                
                
                if isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                else if viewModel.selectableObjects.isEmpty {
                    Spacer()
                    VStack {
                        
                        Image("NoDataImg")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        HStack{
                            Spacer()
                            Text("No data found!").font(.custom("Poppins-Bold", size: 24)).foregroundColor(.gray).padding()
                            Spacer()
                        }
                       
                    }
                    Spacer()
                }
                else {
                    ScrollView {
                        ForEach(viewModel.selectableObjects.indices, id: \.self) { index in
                            Toggle(isOn: self.$viewModel.selectableObjects[index].selected) {
                                HStack {
                                    if let img = self.viewModel.selectableObjects[index].assetImg {
                                        Image(img)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:40)
                                    }
                                    else if let img = self.viewModel.selectableObjects[index].img {
                                        Image(systemName: img).foregroundStyle(.gray)
                                    }
                                    VStack(alignment:.leading, spacing: 0) {
                                        HStack(alignment:.center, spacing:5) {
                                            if let status = self.viewModel.selectableObjects[index].isActive {
                                                Circle().fill(status ? .green : .red).frame(width: 8, height: 8)
                                            }
                                            if let secondaryName = self.viewModel.selectableObjects[index].secondaryName {
                                                Text("\(self.viewModel.selectableObjects[index].name) \(secondaryName)")
                                            }
                                            else {
                                                Text(self.viewModel.selectableObjects[index].name)
                                            }
                                        }
                                        if let email = self.viewModel.selectableObjects[index].email {
                                            Text(email).foregroundStyle(.gray).font(.custom("Poppins-SemiBold", size: 12))
                                        }
                                    }
         
                                }.padding()
                            }
                            .tint(Color("MainColor")).padding(.trailing)
                         
                            .onChange(of: self.viewModel.selectableObjects[index].selected) { newValue in
                                if !allowMultipleSelections {
                                    self.toggleChanged(at: index, newValue: newValue)
                                }
                               
                            }
                        }
                    }
                }
     
                Spacer()
            }
            .navigationDestination(isPresented: $navigateToAdd, destination: {
                AddItemSheet<ViewModel>( viewModel: viewModel, toast: $toast, title: addItemTitle, inputName: addItemName, inputImg: addItemImg, inputPlaceholder: addItemPlaceholder, navigation: $navigateToAdd, type: type)
            })
            .font(.custom("Poppins-SemiBold", size: 16))
            .background(Color(red: 19/255, green: 21/255, blue: 27/255))
            .toastView(toast: $toast)
            .task {
                isLoading = true
                let result = await viewModel.getData(type: type)
                isLoading = false
                
            }
        }
    }
    
    private func toggleChanged(at index: Int, newValue: Bool) {
           // Switch off all other toggles when switching one on
           if newValue {
               for otherIndex in viewModel.selectableObjects.indices where otherIndex != index {
                   viewModel.selectableObjects[otherIndex].selected = false
               }
           }
       }
}

#Preview {
    SelectItemSheet(title: "", viewModel: PreviewVM(), showCurrentSheet: .constant(false), canAddNewItem: false, addItemTitle: "", addItemName: "", addItemImg: "", addItemPlaceholder: "", type: .customer).preferredColorScheme(.dark)
}

class PreviewVM: SelectableObjectsProvider {
    func getData(type: SelectableObjectType) async -> APIResponseStatus {
        return .Success
    }
    
    var newSelectableObject: SelectableObject?
    
    var selectableObjects: [Typ] = []
    
    struct Typ: Selectable {
        var isActive: Bool?
        
        var email: String?
        
        var secondaryName: String?
                
        var assetImg: String?
        
        var name = ""
        var selected = false
        var img:String? = nil
    }
    
    func addItem(type: SelectableObjectType) async -> APIResponseStatus {
        return .Success
    }
    
}
