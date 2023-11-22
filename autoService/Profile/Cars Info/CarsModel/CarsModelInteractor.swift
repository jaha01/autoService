//
//  CarsModelInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation

final class CarsModelInteractor {
    
    // MARK: - Private properties
    var presenter: CarsModelPresenter!
    private let carsService: CarsService
    
    init(carsService: CarsService) {
        self.carsService = carsService
    }
    // MARK: - Public properties
    func loadCarsList(query: String) {
        carsService.loadCars(query: query) { [weak self] (result: Result<[String], Error>)  in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.presenter.prepareCarsList(cars: data)
            case .failure(let error):
                self.presenter.showErrorGetCarsList(error: error.localizedDescription)
            }
        }
    }
}
