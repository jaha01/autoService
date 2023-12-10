//
//  NetworkConfig.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation


class NetworkConfig {
    
    let url = "https://suggestions.dadata.ru"
    var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "NETWORKCONFIG_API_KEY") as? String else {
          fatalError("Couldn't find key 'NETWORKCONFIG_API_KEY' in 'Info.plist'.")
        }
        return value
      }
    }
    
    func headers()->[String:String] {
        return ["Authorization": "Token \(apiKey)",
                "Content-Type": "application/json",
                "Accept" : "application/json"]
    }
    
}
