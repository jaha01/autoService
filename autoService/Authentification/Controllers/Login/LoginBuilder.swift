//
//  LoginBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.10.2023.
//

import UIKit

protocol LoginBuilderProtocol {
    func build() -> UIViewController
}

final class LoginBuilder: LoginBuilderProtocol {
    func build() -> UIViewController {
        let controller = LoginViewController()
        let interactor = LoginInteractor(authService: DI.shared.authService)
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}

//final class NewLoginBuilder: LoginBuilderProtocol {
//    func build() -> UIViewController {
//        return // ...
//    }
//}
