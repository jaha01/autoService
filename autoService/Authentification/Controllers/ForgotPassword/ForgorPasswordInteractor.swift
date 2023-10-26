//
//  ForgorPasswordInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ForgotPasswordInteractor {
    
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
                self.presenter.showError(alertRequest: AlertConfig(title: "", message: error.localizedDescription))
                return
            }
            
            self.presenter.showSuccess(alertRequest: AlertConfig(title: "", message: "Password reset sent"))

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.router.goToLogin()
            }
        }
    }
    
}
