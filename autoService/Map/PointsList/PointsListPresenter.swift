//
//  PointsListPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation

final class PointsListPresenter {
    
    // MARK: - Public properties
    
    weak var controller: PointsListViewController!
    
    func preparePointsToShow(points: [MapPoint]) {
        controller.showPoints(list: points)
    }
}
