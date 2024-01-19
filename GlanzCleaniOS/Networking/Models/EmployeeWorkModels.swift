//
//  EmployeeWorkModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import Foundation

extension GET {
    struct EmployeeWork:Codable,Identifiable {
        var id: String
        var employeeId: String
        var workId: String
    }
}

extension POST {
    struct EmployeeWork:Codable, DictionaryConvertible {
        var employeeId: String
        var workId: String
    }
}

extension PUT {
    struct EmployeeWork:Codable, DictionaryConvertible {
        var employeeId: String
        var workId: String
    }
}

extension DELETE {
    struct EmployeeWork:Codable {
        var id: String
    }
}



