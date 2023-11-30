//
//  CarsModelBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation
import UIKit

final class CarsModelBuilder {
    
    func build(delegate: CarsModelViewControllerDelegate) -> UIViewController {
        let controller = CarsModelViewController()
        let interactor = CarsModelInteractor(carsService: DI.shared.carsService)
        let presenter = CarsModelPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.controller = controller
        controller.delegate = delegate
        
        return controller
    }
}
