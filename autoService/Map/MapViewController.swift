//
//  MapViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 29.08.2023.
//

import UIKit
import YandexMapsMobile

final class MapViewController: UIViewController {
    
    // MARK: - Public properties
    
    var interactor: MapInteractor!
    
    // MARK: Private properties
    
    private let mapView: YMKMapView = {
        let view = YMKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        setConstraints()
        title = "Карты"
        let tap = UITapGestureRecognizer(target: self, action: #selector(toucheScreen))
        view.addGestureRecognizer(tap)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: 55.669757585559445, longitude: 37.76495471766904),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
    }
    
    // MARK: - Private methods
    
    @objc func toucheScreen(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        let tappedPoint = YMKScreenPoint(x: Float(touchPoint.x), y: Float(touchPoint.y))
        let worldPoint = mapView.mapWindow.screenToWorld(with: tappedPoint) ?? YMKPoint()

        AlertManager.showTapInfo(title: "Attention", message: "You have tapped point \(worldPoint.latitude):\(worldPoint.longitude)") { [weak self] in
            guard let self = self else { return }
            self.interactor.saveMapPoint(latitude: String(worldPoint.latitude), longitude: String(worldPoint.longitude))
        }
    }
    
    private func move(_ map: YMKMap, to point: YMKPoint = YMKPoint(latitude: 79.935493, longitude: 40.327392)) {
        let cameraPosition = YMKCameraPosition(target: point, zoom: 17.0, azimuth: 150.0, tilt: 30.0)
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }
    
//    private func addPlacemark(_ map: YMKMap) {
//        let image = UIImage(named: "placemark_icon") ?? UIImage()
//        let placemark = map.mapObjects.addPlacemark()
//        placemark.geometry = YMKPoint(latitude: 59.935493, longitude: 30.327392)
//        placemark.setIconWith(image)
//    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
