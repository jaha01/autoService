//
//  OnboardingRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

protocol OnboardingRouterProtocol {
    func goToLogin()
    func goToMain()
}

final class OnboardingRouter: OnboardingRouterProtocol {
    weak var viewController: UIViewController!
    
    // MARK: - Public methods
    
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
