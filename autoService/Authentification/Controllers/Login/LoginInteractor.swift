//
//  LoginInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.10.2023.
//

import Foundation

final class LoginInteractor {
    
    var presenter: LoginPresenter!
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn(loginRequest: LoginUserRequest) {
        authService.signIn(with: loginRequest) { error in // Do we need [weak self] here?
            
            if let error = error {
                self.presenter.showError(alertRequest: AlertRequest(title: "Signin in Error", message: "\(error.localizedDescription)"))
                return
            }
            
            self.presenter.presentViewController(vc: MainTabBabViewController())
            
//            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                sceneDelegate.checkAuthentification()
//            }
        }
    }
}
