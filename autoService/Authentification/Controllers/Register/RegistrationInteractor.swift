//
//  RegisterInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

protocol RegistrationInteractorProtocol {
    func registerUser(registerUserCredentials: RegisterUserCredentials)
}

final class RegistrationInteractor: RegistrationInteractorProtocol {
    
    var router: RegistrationRouter!
    var presenter: RegistrationPresenter!
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func registerUser(registerUserCredentials: RegisterUserCredentials) {
        authService.registerUser(with: registerUserCredentials) { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.presenter.showError(config: AlertConfig( title: "Unknown Registration Error", message: "\(error.localizedDescription)"))
                return
            }
            
            self.router.goToMain()
        }
    }
}
