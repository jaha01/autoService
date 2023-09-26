//
//  AuthInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 26.09.2023.
//

import Foundation
import FirebaseAuth

final class AuthInteactor {
    var presenter: AuthPresenter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func onViewDidLoad() {
//        presenter.prepareToShowAuthData()
    }
    
    func authentification() -> Auth {
        authService.firebaseAuth()
    }

}
