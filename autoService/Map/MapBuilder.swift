//
//  MapBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class MapBuilder {
    func build() -> UIViewController {
        let controller = MapViewController()
        let interactor = MapInteractor(authService: DI.shared.authService)
        let presenter = MapPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
