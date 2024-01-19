//
//  LengthValidationStrategy.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class LengthValidationStrategy: ValidationStrategy {
    let minLength: Int
    
    init(_ minLength: Int) {
        self.minLength = minLength
    }
    
    func validate(data: String) -> Bool {
        return data.count <= minLength
    }
}

