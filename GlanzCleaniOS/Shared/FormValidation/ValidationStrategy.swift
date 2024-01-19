//
//  ValidationStrategy.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
protocol ValidationStrategy {
    func validate(data: String) -> Bool
}


