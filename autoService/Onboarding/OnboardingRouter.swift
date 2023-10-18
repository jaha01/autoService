//
//  OnboardingRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

final class OnboardingRouter {
    var viewController: UIViewController!
    
    func redirectToView() {
        
        let window = viewController.view.window
        let setupService = DI.shared.createSetupService()
        
        switch setupService.getEntryScreen() {
        case .auth:
            let builder = LoginBuilder()
            window?.rootViewController = builder.build()
        case .mainTabBar:
            window?.rootViewController = MainTabBabViewController()
        default: return
        }
    }
}
