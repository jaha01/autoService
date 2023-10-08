//
//  AuthBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 04.10.2023.
//

import UIKit

final class AuthBuilder {
    func build() -> UIViewController {
        let controller = AuthViewController()
        let interactor = AuthInteractor(authService: DI.shared.authService)
        let presenter = AuthPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
