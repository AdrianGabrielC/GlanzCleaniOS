//
//  EmployeeModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
extension GET {
    struct Employee:Codable, Identifiable {
        var id: String
        var firstName: String
        var lastName: String
        var isActive: Bool
        var email: String
        var phone: String
        var address: String
        
        var work: [GET.Work]?
    }
}

extension POST {
    struct Employee:Codable, DictionaryConvertible {
        var firstName: String
        var lastName: String
        var isActive: Bool
        var email: String
        var phone: String
        var address: String
    }
}

extension PUT {
    struct Employee:Codable, DictionaryConvertible {
        var firstName: String
        var lastName: String
        var isActive: Bool
        var email: String
        var phone: String
        var address: String
    }
}

extension DELETE {
    struct Employee:Codable {
        var id: String
    }
}


