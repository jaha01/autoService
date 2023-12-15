//
//  MapRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation
import UIKit

protocol MapRouterProtocol {
    func showPointsList(points: [MapPoint])
}

final class MapRouter: MapRouterProtocol {
    
    // MARK: - Public properties
    
    weak var viewController: UIViewController!
    
    // MARK: - Public methods
    
    func showPointsList(points: [MapPoint]) {
        guard let mapController = viewController as? MapViewController else { return }
        let pointsListVC = PointsListBuilder().build(points: points, delegate: mapController)
        let nav = UINavigationController(rootViewController: pointsListVC)
        nav.navigationBar.backgroundColor = .white
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 25
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        viewController.present(nav, animated: true, completion: nil)
    }
}
