//
//  ProfileInfo.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.11.2023.
//

import UIKit

struct ProfileInfo {
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

struct ProfileInfoNew {
   
    let email: String
    let phone: String
    let name: String
    let city: String
    let experience: String
    let bday: String
    let brand: String
    let model: String
    let year: String
    let volume: String
    let mileage: String

}
