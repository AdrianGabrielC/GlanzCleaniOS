//
//  OperationModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import Foundation
extension GET {
    struct Operation:Codable,Identifiable {
        var id: String
        var name: String
    }
}

extension POST {
    struct Operation:Codable, DictionaryConvertible {
        var name: String
    }
}

extension PUT {
    struct Operation:Codable, DictionaryConvertible {
        var name: String
    }
}

extension DELETE {
    struct Operation :Codable{
        var id: String
    }
}
