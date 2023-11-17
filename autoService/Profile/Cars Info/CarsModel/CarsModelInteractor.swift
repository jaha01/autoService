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
    private let carsService: CarsService!
    
    init(carsService: CarsService) {
        self.carsService = carsService
    }
    
    func loadCarsList(query: String) {
        carsService.loadCars(query: query) { (result: Result<[String], Error>)  in
            switch result {
            case .success(let success):
                print("success = \(success)")
            case .failure(let failure):
                print("failure = \(failure)")
            }
        }
    }
}
