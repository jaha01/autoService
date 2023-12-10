//
//  MapInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.12.2023.
//

import Foundation

final class MapInteractor {
    
    // MARK: Public properties
    
    var presenter: MapPresenter!
    var router: MapRouter!
    
    // MARK: - Private properties
    
    private let dbService: DBService
    
    // MARK: Initializer
    
    init(dbService: DBService) {
        self.dbService = dbService
    }
    
    // MARK: Public methods
    
    func saveMapPoint(pointInfo: MapPoints) {
        dbService.uploadMapPoint(pointInfo: pointInfo)
    }
    
    func showPointsList() {
        router.showPointsList()
    }
}
