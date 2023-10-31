//
//  DBStruct.swift
//  autoService
//
//  Created by Jahongir Anvarov on 25.10.2023.
//

import Foundation

struct JournalItem {
    var name: String
    var id: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["item"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
    }
}
