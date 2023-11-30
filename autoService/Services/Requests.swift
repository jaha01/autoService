//
//  Request.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.11.2023.
//

import Foundation

enum Requests {
    case carsList
    
    var path: String {
        switch self {
        case .carsList:
            return "/suggestions/api/4_1/rs/suggest/car_brand"
        }
    }
}
