//
//  AuthPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import Foundation

final class AuthPresenter {
    
    weak var viewController: AuthViewController!
 
    func prepareToShowAuthViewControllerData() {
        // mapping, etc...
        viewController.showAuthViewController()
    }
}
