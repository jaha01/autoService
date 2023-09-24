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
        let interactor = OnboardingInteractor(authService: DI.shared.authService)
        let presenter = OnboardingPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
