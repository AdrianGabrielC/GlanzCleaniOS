//
//  APIResponse.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
enum APIResponseStatus {
    case Success
    case Failure
}

struct APIResponse<T:Codable> {
    let status: APIResponseStatus
    let message: String?
    let data: [T]?
}
