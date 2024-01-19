//
//  AuthResponses.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 18.01.2024.
//

import Foundation




struct LoginResponse:Codable {
    var StatusCode: Int?
    var Message: String?
    var token: String?
}

struct RegisterResponse: Codable{
    
}
