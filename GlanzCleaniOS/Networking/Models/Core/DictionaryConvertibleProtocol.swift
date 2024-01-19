//
//  DictionaryConvertibleProtocol.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 18.01.2024.
//

import Foundation

protocol DictionaryConvertible {
    func toDictionary() -> [String: Any]
}

extension DictionaryConvertible {
    func toDictionary() -> [String: Any] {
           let mirror = Mirror(reflecting: self)
           var dict: [String: Any] = [:]
           
           for (key, value) in mirror.children {
               guard let key = key else {
                   continue
               }
               dict[key] = value
           }
           
           return dict
       }
}
