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
    
    // MARK: - Initializer
    
    init(dbService: DBService) {
        self.dbService = dbService
    }
    
    // MARK: - Public methods
    
    func didTapPoint() {
        router.close()
    }
    
    func pointAfterLoad(points: [MapPoint]) {
        presenter.preparePointsToShow(points: points)
    }
}
