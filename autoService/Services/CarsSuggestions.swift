//
//  CarsSuggestions.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation

struct CarsSuggestions: Codable {
    let suggestions: [CarInfo]
}

struct CarInfo: Codable {
    let value: String
    let unrestrictedValue: String
    let data: CarNameInfo
}

struct CarNameInfo: Codable {
    let id: String
    let name: String
    let nameRu: String
}
