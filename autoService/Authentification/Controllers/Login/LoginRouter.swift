//
//  LoginRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

protocol LoginRouterProtocol {
    func goToMain()
    func goToRegistration()
    func goToForgotPassword()
}

final class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController!
    
    func goToMain(){
        let mainController: UIViewController = MainTabBabViewController()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
    
    func goToRegistration() {
        let registration: UIViewController = RegistrationBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = registration
    }
    
    func goToForgotPassword() {
        let forgotPassword: UIViewController = ForgotPasswordBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = forgotPassword
    }
}
