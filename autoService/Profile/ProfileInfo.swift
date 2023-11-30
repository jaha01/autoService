//
//  ProfileInfo.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.11.2023.
//

import UIKit

struct ProfileInfo {
    
    let email: String
    let phone: String
    let name: String
    let city: String
    let experience: String
    let birthday: String
    let brand: String
    let model: String
    let year: String
    let volume: String
    let mileage: String
    
    
    init(email: String,
         phone: String,
         name: String,
         city: String,
         experience: String,
         birthday: String,
         brand: String,
         model: String,
         year: String,
         volume: String,
         mileage: String
    ) {
        self.email = email
        self.phone = phone
        self.name = name
        self.city = city
        self.experience = experience
        self.birthday = birthday
        self.brand = brand
        self.model = model
        self.year = year
        self.volume = volume
        self.mileage = mileage
    }
    
    init(json: [String: Any]) {
        self.init(
            email: json["email"] as! String,
            phone: json["phone"] as! String,
            name: json["name"] as! String,
            city: json["city"] as! String,
            experience: json["experience"] as! String,
            birthday: json["birthday"] as! String,
            brand: json["brand"] as! String,
            model: json["model"] as! String,
            year: json["year"] as! String,
            volume: json["volume"] as! String,
            mileage: json["mileage"] as! String
        )
    }
    
    func toJson() -> [String: Any] {
        return ["email": self.email,
                "phone": self.phone,
                "name": self.name,
                "city": self.city,
                "experience": self.experience,
                "birthday": self.birthday,
                "brand": self.brand,
                "model": self.model,
                "year": self.year,
                "volume": self.volume,
                "mileage": self.mileage] as [String: Any]
    }
    
}
