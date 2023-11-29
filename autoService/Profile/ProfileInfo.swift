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
    
    init(json: [String: Any]) {
        self.email = json["email"] as! String
        self.phone = json["phone"] as! String
        self.name = json["name"] as! String
        self.city = json["city"] as! String
        self.experience = json["experience"] as! String
        self.birthday = json["birthday"] as! String
        self.brand = json["brand"] as! String
        self.model = json["model"] as! String
        self.year = json["year"] as! String
        self.volume = json["volume"] as! String
        self.mileage = json["mileage"] as! String
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
