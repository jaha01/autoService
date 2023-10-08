//
//  RegisterInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class RegisterInteractor {
    
    var presenter: RegisterPresenter!
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func registerUser(registerUserRequest: RegisterUserRequest) {
        authService.registerUser(with: registerUserRequest) { error in
            
            if let error = error {
                self.presenter.showError(alertRequest: AlertRequest( title: "Unknown Registration Error", message: "\(error.localizedDescription)"))
                return
            }
            
            self.presenter.presentViewController(vc: AuthBuilder().build())
        }
    }
}
