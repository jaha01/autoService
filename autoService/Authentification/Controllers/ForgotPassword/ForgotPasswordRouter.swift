//
//  ForgotPasswordRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

final class ForgotPasswordRouter {
    weak var viewController: UIViewController!
    
    func goToLogin() {
        let mainController: UIViewController = LoginBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
}
