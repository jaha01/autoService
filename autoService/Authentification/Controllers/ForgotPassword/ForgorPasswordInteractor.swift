//
//  ForgorPasswordInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ForgotPasswordInteractor {
    
    var presenter: ForgotPasswordPresenter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func forgotPassword(email: String) {
        authService.forgotPassword(with: email) { error in
            if let error = error {
                self.presenter.showError(alertRequest: AlertRequest(title: "", message: error.localizedDescription))
                return
            }
            
            self.presenter.showSuccess(alertRequest: AlertRequest(title: "", message: "Password reset sent"))
        }
    }
    
}
