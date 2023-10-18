//
//  LoginBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class RegistrationBuilder {
    func build() -> UIViewController {
        let controller = RegistrationViewController()
        let interactor = RegistrationInteractor(authService: DI.shared.authService)
        let presenter = RegistrationPresenter()
        let router =  RegistrationRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}
