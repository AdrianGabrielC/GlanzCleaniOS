//
//  TaxView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI

struct TaxView: View {
    @Environment(\.dismiss) var dismiss
    @State private var corporateIncomeTax = 20
    @State private var vatTax = 18
    @State private var payrollTax = 15
    
    var body: some View {
        VStack(alignment:.leading) {
            Stepper("Corporate Income Tax: \(corporateIncomeTax)%", value: $corporateIncomeTax, in: 0...50)
                .font(.custom("Poppins-Bold", size: 16))
                .padding(.top, 40)
                .padding(.bottom)
            Stepper("Value Added Tax (VAT): \(vatTax)%", value: $vatTax, in: 0...50)
                .font(.custom("Poppins-Bold", size: 16))
                .padding(.bottom)
            Stepper("Payroll Taxes: \(payrollTax)%", value: $payrollTax, in: 0...50)
                .font(.custom("Poppins-Bold", size: 16))
            
            Spacer()
            YellowButton(text: "Save") {
                
            }
            .padding(.bottom, 40)
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
                        Text("Change tax") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
}

#Preview {
    TaxView()
}
