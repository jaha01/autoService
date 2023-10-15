//
//  ForgotPasswordRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.10.2023.
//

import UIKit

final class ForgotPasswordRouter {
    var controller: UIViewController!
    
    func goToLogin() {
        let loginVC: UIViewController = LoginViewController()
        let window = controller.view.window
        window?.rootViewController = loginVC
    }
}
