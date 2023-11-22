//
//  CarsModelPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation

final class CarsModelPresenter {
    weak var controller: CarsModelViewController!
    
    func prepareCarsList(cars: [String]) {
        controller.pushCarsList(cars: cars)
    }
    
    func showErrorGetCarsList(error: String) {
        controller.showErrorAlert(config: AlertConfig(title: "Error", message: error))
    }
}
