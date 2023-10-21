//
//  OnboardingRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

final class OnboardingRouter {
    weak var viewController: UIViewController!
    
    func goToLogin() {
        let window = viewController.view.window
        let builder = LoginBuilder()
        window?.rootViewController = builder.build()
    }
    
    func goToMain() {
        let window = viewController.view.window
        window?.rootViewController = MainTabBabViewController()
    }
}
