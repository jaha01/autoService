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

protocol SetupServiceProtocol {
    func getEntryScreen() ->  EntryScreen
}

final class SetupService: SetupServiceProtocol {
    
    private let authService: AuthServiceProtocol
    
    
    init(authService: AuthServiceProtocol) {
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
