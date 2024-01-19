//
//  AuthModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import Foundation


extension POST {
    struct Register:Codable, DictionaryConvertible {
        var firstName: String?
        var lastName: String?
        var password: String?
        var email: String?
        var phone: String?
        var address: String?
        var isActive: Bool?
        var roles: [String]?
    }
    struct Login:Codable, DictionaryConvertible {
        var userName: String?
        var password: String?
    }
}

extension PUT {
    struct ChangePass:Codable, DictionaryConvertible {
        var userName: String
        var newPassword: String
    }
}





