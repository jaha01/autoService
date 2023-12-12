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
    
    private let savedPlacesList: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        setConstraints()
        title = "Карты"

        interactor.getUserLocation()
    }
    
    func setupMap(latitude: Double, longitude: Double) {
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.addGestureRecognizer(tapHandler)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: latitude, longitude: longitude),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil)
    }
    
    // MARK: - Private methods
    
    @objc private func buttonAction() {
        interactor.showPointsList()
    }
    
    @objc func handleScreenTap(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        let tappedPoint = YMKScreenPoint(x: Float(touchPoint.x), y: Float(touchPoint.y))
        let worldPoint = mapView.mapWindow.screenToWorld(with: tappedPoint) ?? YMKPoint()

        AlertManager.showMapTapInfo(config: AlertMapPoint(title: "Вы нажали на точку", point: Point(latitude: worldPoint.latitude, longitude: worldPoint.longitude))) { action in
            self.interactor.saveMapPoint(pointInfo: MapPoint(title: PointTitle(name: action.name, description: action.description), point: Point(latitude: worldPoint.latitude, longitude: worldPoint.longitude)))
        }
    }
    
    private func move(_ map: YMKMap, to point: YMKPoint = YMKPoint(latitude: 79.935493, longitude: 40.327392)) {
        let cameraPosition = YMKCameraPosition(target: point, zoom: 17.0, azimuth: 150.0, tilt: 30.0)
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }
    
    
    private func setConstraints() {
        mapView.addSubview(savedPlacesList)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            savedPlacesList.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            savedPlacesList.trailingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            savedPlacesList.leadingAnchor.constraint(equalTo: savedPlacesList.trailingAnchor, constant: -30),
            savedPlacesList.topAnchor.constraint(equalTo: savedPlacesList.bottomAnchor, constant: -30)
        ])
    }
}

// MARK: - YMKUserLocationObjectListener implementation
extension MapViewController: YMKUserLocationObjectListener {
    
    func onObjectAdded(with view: YMKUserLocationView) {
        view.arrow.setIconWith(UIImage(systemName: "arrow.backward")!)
    
        let pinPlacemark = view.pin.useCompositeIcon()
        
        pinPlacemark.setIconWithName("i.circle",
            image: UIImage(systemName:"i.circle")!,
            style:YMKIconStyle(
                anchor: CGPoint(x: 0, y: 0) as NSValue,
                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 0,
                flat: true,
                visible: true,
                scale: 1.5,
                tappableArea: nil))
        
        pinPlacemark.setIconWithName(
            "pin",
            image: UIImage(systemName:"magnifyingglass")!,
            style:YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 1,
                flat: true,
                visible: true,
                scale: 1,
                tappableArea: nil))

        view.accuracyCircle.fillColor = UIColor.blue
    }

    func onObjectRemoved(with view: YMKUserLocationView) {}

    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
}

// MARK: - PointsListViewControllerDelegate implementation
extension MapViewController: PointsListViewControllerDelegate {
    func show(latitude: Double, longitude: Double) {
        setupMap(latitude: latitude, longitude: longitude)
    }
}
