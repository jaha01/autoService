//
//  ProfileBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfileBuilder {
    func build() -> UIViewController {
        let controller = ProfileViewController()
        let interactor = ProfileInteractor(authService: DI.shared.authService)
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        interactor.router = router
        router.viewController = controller
        
        return controller
    }
}
