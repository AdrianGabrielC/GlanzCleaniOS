//
//  LettersOnlyValidationStrategy.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class LettersOnlyValidationStrategy: ValidationStrategy {
    func validate(data: String) -> Bool {
        return !data.isEmpty && data.lettersOnly
    }
}
