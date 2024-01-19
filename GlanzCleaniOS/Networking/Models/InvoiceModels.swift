//
//  InvoiceModels.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 17.01.2024.
//

import Foundation

extension GET {
    struct Invoice:Codable,Identifiable  {
        var id: String
        var work: GET.Work
    }
    
    struct InvoiceWithoutWork:Codable {
        var id: String
        var workId: String
    }
}

extension POST {
    struct Invoice:Codable, DictionaryConvertible {
        var workId: String
    }
}

extension PUT {
    struct Invoice:Codable, DictionaryConvertible {
        var workId: String
    }
}

extension DELETE {
    struct Invoice:Codable {
        var id: String
    }
}






