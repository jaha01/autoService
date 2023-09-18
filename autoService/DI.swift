//
//  DI.swift
//  autoService
//
//  Created by Jahongir Anvarov on 13.09.2023.
//

import Foundation

final class DI {
    
    static let shared = DI()
    
    lazy var authService : AuthService = { // вызовиться один раз и будет жить
        return AuthService()
    }()
    
//    func createAuthService() -> AuthService { // каждый раз создастся новый
//        return AuthService()
//    }
    
    func createSetupService() -> SetupService {
        return SetupService(authService: authService)
    }
}
