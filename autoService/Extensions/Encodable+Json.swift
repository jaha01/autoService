//
//  Encodable+Json.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.11.2023.
//

import Foundation

extension Encodable {
    func toJsonData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
