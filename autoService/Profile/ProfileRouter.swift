//
//  ProfileRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 01.11.2023.
//

import UIKit

class ProfileRouter {
    weak var viewController: UIViewController!
    
    func goToLogin() {
        let login: UIViewController = ForgotPasswordBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = login
    }
    
}
