//
//  DataValidator.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class DataValidator {
    private let validationStrategy: ValidationStrategy
    
    init(validationStrategy: ValidationStrategy) {
        self.validationStrategy = validationStrategy
    }
    
    func validateData(data: String) -> Bool {
        return validationStrategy.validate(data: data)
    }
 
}
