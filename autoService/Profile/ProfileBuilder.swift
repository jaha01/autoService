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
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
