//
//  AuthPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 26.09.2023.
//

import Foundation

final class AuthPresenter {
    
    weak var authViewController: AuthViewController!
    
    func prepareToShowAuthData() {
        authViewController.showAuthViewController()
    }
}
