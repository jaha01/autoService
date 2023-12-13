//
//  PointsListInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation

final class PointsListInteractor {
   
    // MARK: Public properties
    
    var presenter: PointsListPresenter!
    var router: PointsListRouter!
    
    // MARK: - Private properties
    
    private let dbService: DBService
    private let points: [MapPoint]
    
    // MARK: - Initializer
    
    init(points: [MapPoint], dbService: DBService) {
        self.dbService = dbService
        self.points = points
    }
    
    // MARK: - Public methods
    
    func onViewDidLoad() {
        presenter.preparePointsToShow(points: points)
    }
    
    func didTapPoint() {
        router.close()
    }
}
