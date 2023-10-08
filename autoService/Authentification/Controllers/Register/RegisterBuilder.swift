//
//  LoginBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class RegisterBuilder {
    func build() -> UIViewController {
        let controller = RegisterViewController()
        let interactor = RegisterInteractor(authService: DI.shared.authService)
        let presenter = RegisterPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
