//
//  CarsModelPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation

final class CarsModelPresenter {
    weak var controller: CarsModelViewController!
    
    func prepareCarsList(cars: [CarInfo]) {
        
        let brands = cars.map { $0.data.nameRu
        }
        controller.showCarsList(cars: brands)
    }
    
    func showError(error: String) {
        controller.showErrorAlert(config: AlertConfig(title: "Error", message: error))
    }
}
