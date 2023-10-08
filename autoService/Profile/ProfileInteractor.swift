//
//  ProfileInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfileInteractor {
    
    var presenter: ProfilePresenter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func userSignOut() {
        
        authService.signOut { error in
            if let error = error {
                self.presenter.showError(alertRequest: AlertRequest(title: "Unknown Signin in Error", message: "\(error.localizedDescription)"))
                return
            }
            
            self.presenter.presentViewController(vc: LoginBuilder().build())
        }
        
    }
}
