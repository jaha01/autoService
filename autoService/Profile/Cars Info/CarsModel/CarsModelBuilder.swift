//
//  CarsModelBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation
import UIKit

final class CarsModelBuilder {
    
    func build() -> UIViewController {
        let controller = CarsModelViewController()
        let interactor = CarsModelInteractor(carsService: DI.shared.carsService)
        let presenter = CarsModelPresenter()
        let profileViewController = ProfileViewController()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.controller = controller
        controller.profileViewController = profileViewController
//        profileViewController.carsModel = controller
        
        return controller
    }
}
