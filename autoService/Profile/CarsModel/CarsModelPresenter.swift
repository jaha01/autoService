//
//  CarsModelPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation

protocol CarsModelPresenterProtocol {
    func prepareCarsList(cars: [CarInfo])
    func showError(error: String)
}

final class CarsModelPresenter: CarsModelPresenterProtocol {
    
    // MARK: - Public properties
    
    weak var controller: CarsModelViewControllerProtocol!
    
    // MARK: - Public methods
    
    func prepareCarsList(cars: [CarInfo]) {
        
        let brands = cars.map { $0.data.nameRu }
        controller.showCarsList(cars: brands)
    }
    
    func showError(error: String) {
        controller.showErrorAlert(config: AlertConfig(title: "Error", message: error))
    }
}
