//
//  ResponseWrapper.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 18.01.2024.
//

import Foundation

struct ResponseWrapper<T:Codable>: Codable {
    var StatusCode: Int?
    var Message: String?
    var Data: T?
}
