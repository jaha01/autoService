//
//  SetupService.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.09.2023.
//

import Foundation
import UIKit
import FirebaseAuth


enum EntryScreen {
    case onboarding
    case auth
    case mainTabBar
}

final class SetupService {
    
    private let authService: AuthService
    
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func getEntryScreen() ->  EntryScreen {
       
        if authService.isNewUser() {
            return .onboarding
        }

        if !authService.isCurrentUserExists() {
            return .auth
        }
        
        return .mainTabBar
        
    }
    
}
