//
//  MapPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation

protocol MapPresenterProtocol {
    func prepareUserLocation(latitude: Double, longitude: Double)
}

final class MapPresenter: MapPresenterProtocol {
    
    // MARK: - Public properties
    
    weak var viewController: MapViewControllerProtocol!
 
    // MARK: - Public methods
    
    func prepareUserLocation(latitude: Double, longitude: Double) {
        viewController.moveMap(to: Point(latitude: latitude, longitude: longitude))
    }
}
