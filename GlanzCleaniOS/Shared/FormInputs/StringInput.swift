//
//  StringInput.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
struct StringInput {
    var input: String = ""
    var isValid: Bool {
        return validators.reduce(true, { partialResult, validator in
            return partialResult && validator.validateData(data: input)
        })
    }
    var validators: [DataValidator]
    var errInfo: String
    
    init(errInfo: String, validators: [DataValidator]) {
        self.errInfo = errInfo
        self.validators = validators
    }
}

