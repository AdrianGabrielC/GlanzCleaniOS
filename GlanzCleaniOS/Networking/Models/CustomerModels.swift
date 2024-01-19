//
//  CustomerModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import Foundation
extension GET {
    struct Customer :Codable,Identifiable{
        var id: String
        var name: String
    }
}

extension POST {
    struct Customer:Codable, DictionaryConvertible {
        var name: String
    }
}

extension PUT {
    struct Customer:Codable, DictionaryConvertible {
        var name: String
    }
}

extension DELETE {
    struct Customer :Codable{
        var id: String
    }
}

