//
//  NetworkConfig.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation

class NetworkConfig {
    
    let url = "https://suggestions.dadata.ru"
    
    func headers()->[String:String] {
        return ["Authorization": "Token \(ApiKeys.daData)",
                "Content-Type": "application/json",
                "Accept" : "application/json"]
    }
    
}
