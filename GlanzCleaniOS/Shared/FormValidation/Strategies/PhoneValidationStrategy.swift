//
//  PhoneValidationStrategy.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class PhoneValidationStrategy: ValidationStrategy {
    func validate(data: String) -> Bool {
        return data != "" && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: data))
    }
}
