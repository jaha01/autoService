//
//  Request.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.11.2023.
//

import Foundation

enum Requests {
    case common
    
    var path: String {
        switch self {
        case .common:
            return "/suggestions/api/4_1/rs/suggest/car_brand"
        }
    }
}


struct CarsListRequestBody: Codable {
    let query: String
}
