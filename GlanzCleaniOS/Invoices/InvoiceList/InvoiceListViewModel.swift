//
//  InvoiceListViewModel.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import Foundation

class InvoiceListViewModel: ObservableObject {
    
    @Published var PDFUrl: URL?
    @Published var showShareSheet: Bool = false
}
