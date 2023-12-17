//
//  PointsListRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation

protocol PointsListRouterProtocol {
    func close()
}

final class PointsListRouter: PointsListRouterProtocol {
    
    // MARK: - Public properties
    
    weak var controller: PointsListViewController!
    
    func close() {
        controller.dismiss(animated: true, completion: nil)
    }
}
