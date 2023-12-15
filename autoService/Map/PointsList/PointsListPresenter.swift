//
//  PointsListPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation

protocol PointsListPresenterProtocol {
    func preparePointsToShow(points: [MapPoint])
}

final class PointsListPresenter: PointsListPresenterProtocol {
    
    // MARK: - Public properties
    
    weak var controller: PointsListViewController!
    
    func preparePointsToShow(points: [MapPoint]) {
        controller.showPoints(list: points)
    }
}
