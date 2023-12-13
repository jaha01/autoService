//
//  ApiKeys.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.12.2023.
//

import Foundation

final class ApiKeys {
    static let daData = Bundle.main.object(forInfoDictionaryKey: "NETWORKCONFIG_API_KEY") as! String
    static let yandexMaps = Bundle.main.object(forInfoDictionaryKey: "YMKMAPKIT_API_KEY") as! String
}
