//
//  AsyncText.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import SwiftUI

struct AsyncText: View {
    var text: String?
    
    var body: some View {
        if let text = text {
            Text(text)
        }
        else {
            ProgressView()
        }
    }
}
