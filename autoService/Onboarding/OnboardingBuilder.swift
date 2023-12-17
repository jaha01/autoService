//
//  OnboardingBuilder.swift
//  autoService
//
//  Created by Yaroslav Magin on 20.09.2023.
//

import UIKit

final class OnboardingBuilder {
    func build() -> UIViewController {
        let controller = OnboardingViewController()
        let interactor = OnboardingInteractor(authService: DI.shared.authService, setupService: DI.shared.createSetupService())
        let presenter = OnboardingPresenter()
        let router = OnboardingRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}
