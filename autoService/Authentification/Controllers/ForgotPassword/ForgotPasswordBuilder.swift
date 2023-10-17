//
//  ForgotPasswordBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ForgotPasswordBuilder {
    func build() -> UIViewController {
        let controller = ForgotPasswordViewController()
        let interactor = ForgotPasswordInteractor(authService: DI.shared.authService)
        let presenter = ForgotPasswordPresenter()

        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
