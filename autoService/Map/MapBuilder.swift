//
//  MapBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.11.2023.
//

import Foundation
import UIKit

class MapBuilder {
    
    func build() -> UIViewController {
        let controller = MapViewController()
        let interactor = MapInteractor(authService: DI.shared.authService)
        let presenter = MapPresenter()
        let router = MapRouter()
            
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        interactor.router = router
        router.viewController = controller
        
        return controller
    }
}
