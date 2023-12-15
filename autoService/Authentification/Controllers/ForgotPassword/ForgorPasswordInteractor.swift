//
//  ForgorPasswordInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

protocol ForgotPasswordInteractorProtocol {
    func resetPassword(email: String)
    func didTapLogin()
}

final class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol {
    
    var router: ForgotPasswordRouter!
    var presenter: ForgotPasswordPresenter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func resetPassword(email: String) {
        authService.resetPassword(with: email) { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.presenter.showError(config: AlertConfig(title: "", message: error.localizedDescription))
                return
            }
            self.presenter.showPasswordResetInfo(title: "", message: "Password reset sent")
        }
    }
    
    func didTapLogin() {
        router.goToLogin()
    }
}
