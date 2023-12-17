//
//  CarsModelInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 17.11.2023.
//

import Foundation

protocol CarsModelInteractorProtocol {
    func loadCarsList(query: String)
}

final class CarsModelInteractor: CarsModelInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: CarsModelPresenterProtocol!
    
    // MARK: - Private properties

    private let carsService: CarsServiceProtocol
    
    // MARK: - Initializer
    
    init(carsService: CarsServiceProtocol) {
        self.carsService = carsService
    }

    // MARK: - Public methods
    
    func loadCarsList(query: String) {
        carsService.loadCars(query: query) { [weak self] (result: Result<CarsSuggestions, Error>)  in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.presenter.prepareCarsList(cars: data.suggestions)
            case .failure(let error):
                self.presenter.showError(error: error.localizedDescription)
            }
        }
    }
}
