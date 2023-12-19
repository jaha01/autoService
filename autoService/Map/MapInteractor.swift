//
//  MapInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation
import MapKit
import CoreLocation

protocol MapInteractorProtocol {
    func saveMapPoint(pointInfo: MapPoint)
    func showPointsList()
    func onViewDidLoad()
}

final class MapInteractor: NSObject, MapInteractorProtocol {
    
    // MARK: Public properties
    
    var presenter: MapPresenterProtocol!
    var router: MapRouterProtocol!
    
    // MARK: - Private properties
    
    private let dbService: MapPointsServiceProtocol
    private let locationManager = CLLocationManager()
    private var mapPoints = [MapPoint]()
    
    // MARK: Initializer
    
    init(dbService: MapPointsServiceProtocol) {
        self.dbService = dbService
    }
    
    // MARK: Public methods
    
    func saveMapPoint(pointInfo: MapPoint) {
        dbService.uploadMapPoint(pointInfo: pointInfo)
    }
    
    func showPointsList() {
        router.showPointsList(points: mapPoints)
    }
    
    func onViewDidLoad() {
        dbService.setupMapPointsListeners { [weak self] points in
            guard let self = self else { return }
            self.mapPoints = points
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - CLLocationManagerDelegate Implementation
extension MapInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            presenter.prepareUserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
}
