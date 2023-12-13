//
//  MapPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation

final class MapPresenter {
    
    // MARK: - Public properties
    
    weak var viewController: MapViewController!
 
    // MARK: - Public methods
    
    func prepareUserLocation(latitude: Double, longitude: Double) {
        viewController.moveMap(to: Point(latitude: latitude, longitude: longitude))
    }
}
