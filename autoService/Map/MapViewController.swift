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

        setupMap()
    }
    
    // MARK: - Private methods
    
    private func userCurrentLocation() { // not working
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.move(with:
            YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 14, azimuth: 0, tilt: 0))
        
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)

        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        userLocationLayer.setObjectListenerWith(self)
    }
    
    private func setupMap() {
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.addGestureRecognizer(tapHandler)
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
    
    @objc func handleScreenTap(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        let tappedPoint = YMKScreenPoint(x: Float(touchPoint.x), y: Float(touchPoint.y))
        let worldPoint = mapView.mapWindow.screenToWorld(with: tappedPoint) ?? YMKPoint()

        AlertManager.showTapInfo(config: AlertConfig(title: "Attention", message: "You have tapped point \(worldPoint.latitude):\(worldPoint.longitude)")) { [weak self] in
            guard let self = self else { return }
            //self.interactor.saveMapPoint(latitude: worldPoint.latitude, longitude: worldPoint.longitude)
        }
        
//        let alert = UIAlertController(title: "example", message: "", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alert.addTextField { textField in
//            textField.placeholder = "please enter name"
//        }
//        let ok = UIAlertAction(title: "OK", style: .default) { action in
//            if let name = alert.textFields?.first?.text {
//                print(name)
//            }
//        }
//        alert.addAction(ok)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
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
