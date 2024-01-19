//
//  EmptyValidationStrategy.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
class EmptyValidationStrategy: ValidationStrategy {
    func validate(data: String) -> Bool {
        return !data.isEmpty
    }
}
