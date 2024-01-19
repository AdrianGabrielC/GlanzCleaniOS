//
//  InvoiceListView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct InvoiceSectionHeader: View {
    var body: some View {
        HStack {
            Text("January")
            Spacer()
            Text("Total: 6,500€")
        }
    }
}

struct InvoiceListView: View {
    //@EnvironmentObject var toastManager: ToastManager
    @StateObject var viewModel = InvoiceListViewModel()
    @State var searchText = ""
    @State var date = Date()
    @State var pause = 0
    

    var body: some View {
        VStack(alignment: .leading) {
            Text("Invoices")
                .font(.custom("Poppins-Bold", size: 32))
                .padding(.leading, 30)
            HStack(alignment: .bottom) {
                Image("InvoiceImg")
                    .resizable()
                    .scaledToFit()
                    .frame(height:100)
                    .padding(.horizontal)
                Spacer()
                
            }
            HStack {
                CustomSearchBar(text: $searchText)
                NavigationLink(destination: AddInvoiceView()) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 25, height: 25)
                        .padding(5)
                        .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        
                }
            }.padding()
            
            ScrollView {
                HStack {
                    Text("JANUARY")
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .padding(.top)
                    Spacer()
                }
                Invoice(number: "127",
                        customer: "TechBrite",
                        date: "5 Jan, 2023",
                        income: "650,00€",
                        filed: true)
                .padding(.bottom)
                Invoice(number: "128",
                        customer: "CodeWave",
                        date: "6 Jan, 2023",
                        income: "1200,00€",
                        due: true)
                Invoice(number: "129",
                        customer: "TechBrite",
                        date: "6 Jan, 2023",
                        income: "750,00€",
                        filed: true)
                .padding(.bottom)
                Invoice(number: "130",
                        customer: "TechBrite",
                        date: "6 Jan, 2023",
                        income: "750,00€",
                        filed: true)
                .padding(.bottom)
                HStack {
                    Text("FEBRUARY")
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .padding(.top)
                    Spacer()
                }
                Invoice(number: "131",
                        customer: "TechBrite",
                        date: "5 Feb, 2023",
                        income: "650,00€",
                        filed: true)
                .padding(.bottom)
                Invoice(number: "132",
                        customer: "CodeWave",
                        date: "6 Feb, 2023",
                        income: "1200,00€",
                        due: true)
            }
           
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            viewModel.PDFUrl = nil
        } content: {
            if let PDFUrl = viewModel.PDFUrl {
                ShareSheet(urls: [PDFUrl])
            }
        }
    }
    
//    @ViewBuilder
//    func MenuItems() -> some View {
//        Group {
//            Button {
//                exportPDF {
//                    InvoicePdfView()
//                } completion: { status, url in
//                    if let url = url, status {
//                        viewModel.PDFUrl = url
//                        viewModel.showShareSheet = true
//                    }
//                    else {
//                        print("Failed to produce PDF")
//                    }
//                }
//
//            }label: {
//                Text("Share PDF")
//                Image(systemName: "square.and.arrow.up.fill")
//            }
//        }
//    }
    
    @ViewBuilder
    func Invoice(number: String, customer:String, date:String, income:String, filed:Bool = false, due: Bool = false) -> some View {
        HStack {
            VStack(alignment:.center) {
                Image("InvoiceIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25)
                Text(number).font(.custom("Poppins-SemiBold", size: 12))
            }
            VStack(alignment:.leading) {
                Text(customer)
                    .font(.custom("Poppins-SemiBold", size: 14))
                Text(date)
                    .foregroundStyle(.gray)
                    .font(.custom("Poppins-SemiBold", size: 14))
            }
            Spacer()
            VStack {
                Text(income)
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .foregroundColor(filed ? .green : .gray)
                if due {
                    Text("Unpaid")
                        .frame(width: 50, alignment: .center)
                        .background(.gray)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .font(.custom("Poppins-SemiBold", size: 10))
                }
                else if filed {
                    Text("Paid")
                        .frame(width: 40, alignment: .center)
                        .background(.green)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .font(.custom("Poppins-SemiBold", size: 10))
                }
            }
//            Button {
//                exportPDF {
//                    InvoicePdfView()
//                } completion: { status, url in
//                    if let url = url, status {
//                        viewModel.PDFUrl = url
//                        viewModel.showShareSheet = true
//                    }
//                    else {
//                        print("Failed to produce PDF")
//                    }
//                }
//
//            }label: {
//                Image(systemName: "square.and.arrow.up.fill")
//                    .foregroundStyle(Color("MainColor"))
//            }
        }
        .padding(.horizontal)
//        .contextMenu {
//            MenuItems()
//        }
    }
}

#Preview {
    InvoiceListView()
}
