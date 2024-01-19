//
//  FacilityModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import Foundation
extension GET {
    struct Facility :Codable,Identifiable{
        var id: String
        var name: String
    }
}

extension POST {
    struct Facility :Codable, DictionaryConvertible{
        var name: String
    }
}

extension PUT {
    struct Facility:Codable, DictionaryConvertible {
        var name: String
    }
}

extension DELETE {
    struct Facility :Codable{
        var id: String
    }
}
