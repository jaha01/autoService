//
//  MapInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation
import MapKit
import CoreLocation

final class MapInteractor: NSObject, CLLocationManagerDelegate{
    
    // MARK: Public properties
    
    var presenter: MapPresenter!
    var router: MapRouter!
    
    // MARK: - Private properties
    
    private let dbService: DBService
    private let locationManager = CLLocationManager()
    
    // MARK: Initializer
    
    init(dbService: DBService) {
        self.dbService = dbService
    }
    
    // MARK: Public methods
    
    func saveMapPoint(pointInfo: MapPoint) {
        dbService.uploadMapPoint(pointInfo: pointInfo)
    }
    
    func showPointsList() {
        dbService.setupMapPointsListeners { [weak self] points in
            guard let self = self else { return }
            self.router.showPointsList(points: points)
        }
    }
    
    func getUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            presenter.prepareUserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
}
