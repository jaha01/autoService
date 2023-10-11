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
    
    func resetPassword(email: String) {
        authService.resetPassword(with: email) { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.presenter.showError(alertRequest: AlertRequest(title: "", message: error.localizedDescription))
                return
            }
            
            self.presenter.showSuccess(alertRequest: AlertRequest(title: "", message: "Password reset sent"))
        }
    }
    
}
