//
//  MapViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 29.08.2023.
//

import UIKit
import YandexMapsMobile

protocol MapViewControllerProtocol: AnyObject {
    func moveMap(to point: Point) 
}

final class MapViewController: UIViewController, MapViewControllerProtocol {
    
    // MARK: - Public properties
    
    var interactor: MapInteractorProtocol!
    
    // MARK: Private properties
    
    private let mapView: YMKMapView = {
        let view = YMKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let showSavedPlacesButton: UIButton = {
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
        setupMap()
        interactor.onViewDidLoad()
    }
    
    func moveMap(to point: Point) {
        let cameraPosition = YMKCameraPosition(target: YMKPoint(latitude: point.latitude,
                                                                longitude: point.longitude),
                                               zoom: 17.0,
                                               azimuth: 150.0,
                                               tilt: 30.0)
        mapView.mapWindow.map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
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
            self.interactor.saveMapPoint(pointInfo: MapPoint(title: PointInfo(name: action.name, description: action.description), point: Point(latitude: worldPoint.latitude, longitude: worldPoint.longitude)))
        }
    }
    
    private func setupMap() {
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.addGestureRecognizer(tapHandler)
    }
    
    
    private func setConstraints() {
        mapView.addSubview(showSavedPlacesButton)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            showSavedPlacesButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            showSavedPlacesButton.trailingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            showSavedPlacesButton.leadingAnchor.constraint(equalTo: showSavedPlacesButton.trailingAnchor, constant: -30),
            showSavedPlacesButton.topAnchor.constraint(equalTo: showSavedPlacesButton.bottomAnchor, constant: -30)
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
        moveMap(to: Point(latitude: latitude, longitude: longitude))
    }
}
