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
    var dbService: DBService!
    
    // MARK: - Initializer
    
    init(dbService: DBService) {
        self.dbService = dbService
    }
    
    // MARK: - Public methods
    
    func loadListPoints() {
        dbService.setupMapPointsListeners { [weak self] points in
            guard let self = self else { return }
            self.presenter.prepareToShowPoints(list: points)
        }
    }
}
