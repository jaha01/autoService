//
//  JournalInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import Foundation

final class JournalInteractor {
    var presenter: JournalPresenter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
}
