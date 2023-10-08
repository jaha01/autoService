//
//  AuthInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import Foundation

final class AuthInteractor {
    
    var presenter: AuthPresenter!
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    
    func getUserShortInfo() -> String {
        var name: String?
        
        authService.fetchUser { user, error in
//            guard let self = self else { return }  is it correct?
            if let error = error {
                self.presenter.showError(title: "Error fetching user", message: "\(error.localizedDescription)")
                return
            }
            
            if let user = user {
                name = "\(user.username)\n\(user.email)"
            }
        }
        return name ?? ""
    }
    
    func userSignOut() {
        
        authService.signOut { error in
            if let error = error {
                self.presenter.showError(title: "Unknown Signin in Error", message: "\(error.localizedDescription)")
                return
            }
            
            self.presenter.presentViewController(vc: LoginBuilder().build())
        }
        
    }
    
}
