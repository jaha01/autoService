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
        let interactor = ProfileInteractor(authService: DI.shared.authService, dbService: DI.shared.dbService())
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
//        let carsModel = CarsModelViewController()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        interactor.router = router
        router.viewController = controller
//        controller.carsModel = carsModel
//        carsModel.profileViewController = controller
        
        return controller
    }
}
