//
//  CarsSuggestions.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation

struct CarsSuggestions: Codable {
    let suggestions: [CarsList]
}

struct CarsList: Codable {
    let value: String
    let unrestrictedValue: String
    let data: CarData
}

struct CarData: Codable {
    let id: String
    let name: String
    let nameRu: String
}
