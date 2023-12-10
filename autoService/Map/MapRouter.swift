//
//  MapRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation
import UIKit

final class MapRouter {
    
    // MARK: - Public properties
    
    weak var viewController: UIViewController!
    
    // MARK: - Public methods
    
    func showPointsList() {
        guard let mapController = viewController as? MapViewController else { return }
        let tableVC = PointsListBuilder().build(delegate: mapController)
        let nav = UINavigationController(rootViewController: tableVC)
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
