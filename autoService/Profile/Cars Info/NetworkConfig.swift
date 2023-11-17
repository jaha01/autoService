//
//  NetworkConfig.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation


class NetworkConfig {
    
    let url = "https://suggestions.dadata.ru"
    let apiKey = "14f74f1003dc89e19695bc03c84741f75e11cc50"
    
    func headers()->[String:String] { return ["X-Api-Key":apiKey]
    }
    
}

