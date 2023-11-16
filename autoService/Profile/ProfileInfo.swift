//
//  ProfileInfo.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.11.2023.
//

import UIKit

public struct ProfileInfo {
    let section: String
    let item: [Object]
}

struct Object {
    let name: String
    let placeholder: String
}

enum OptionType {
    case item(value: String, placeholder: String)
//    case car(value: String, placeholder: String)
}

