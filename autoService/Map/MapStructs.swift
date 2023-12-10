//
//  Structs.swift
//  autoService
//
//  Created by Jahongir Anvarov on 09.12.2023.
//

import Foundation

struct AlertMapPoints {
    var title: String
    var latitude: Double
    var longitude: Double
}

struct MapPoints {
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    // MARK: - Initializer
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? Double ?? 0
        self.longitude = dictionary["longitude"] as? Double ?? 0
    }
}
