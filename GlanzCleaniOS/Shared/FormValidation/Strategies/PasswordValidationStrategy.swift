//
//  PasswordValidationStrategy.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class PasswordValidationStrategy: ValidationStrategy {
    func validate(data: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*\\d).{7,}$")
        return passwordPredicate.evaluate(with: data)
    }
}
