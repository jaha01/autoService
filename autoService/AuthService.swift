//
//  AuthService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 13.09.2023.
//

import Foundation

final class AuthService {
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
    
}
