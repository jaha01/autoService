//
//  LoginInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.10.2023.
//

import Foundation

protocol LoginInteractorProtocol {
    func signIn(loginRequest: LoginUserCredentials)
    
    func didTapRegistration()
    func didTapForgotPassword()
}

final class LoginInteractor: LoginInteractorProtocol {
    
    var router: LoginRouter!
    var presenter: LoginPresenter!
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn(loginRequest: LoginUserCredentials) {
        authService.signIn(with: loginRequest) { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.presenter.showError(config: AlertConfig(title: "Sign in Error", message: "\(error.localizedDescription)"))
                return
            }
            
            self.router.goToMain()
            
        }
    }
    
    func didTapRegistration() {
        router.goToRegistration()
    }
    
    func didTapForgotPassword() {
        router.goToForgotPassword()
    }
}
