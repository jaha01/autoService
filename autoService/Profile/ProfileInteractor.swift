//
//  ProfileInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfileInteractor {
    
    var presenter: ProfilePresenter!
    var router: ProfileRouter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func userSignOut() {
        
        authService.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.presenter.showError(alertRequest: AlertConfig(title: "Unknown Signin in Error", message: "\(error.localizedDescription)"))
                return
            }
            self.router.goToLogin()
        }
    }
}
