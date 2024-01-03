//
//  ForgotPasswordRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

protocol ForgotPasswordRouterProtocol {
    func goToLogin()
}

final class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    weak var viewController: UIViewController!
    
    // MARK: - Public methods
    
    func goToLogin() {
        let mainController: UIViewController = LoginBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
}
