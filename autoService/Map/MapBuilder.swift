//
//  MapBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation
import UIKit

final class MapBuilder {
    func build() -> UIViewController {
        let controller = MapViewController()
        let interactor = MapInteractor(dbService: DI.shared.dbService())
        let presenter = MapPresenter()
        let router = MapRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        interactor.router = router
        presenter.viewController = controller
        router.viewController = controller
        
        return controller
    }
}
