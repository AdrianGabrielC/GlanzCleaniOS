//
//  EmailValidationStrategy.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class EmailValidationStrategy: ValidationStrategy {
    func validate(data: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailPredicate.evaluate(with: data)
    }
}
