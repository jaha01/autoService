//
//  PointsListInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation

protocol PointsListInteractorProtocol {
    func onViewDidLoad()
    func didTapPoint()
}

final class PointsListInteractor: PointsListInteractorProtocol {
   
    // MARK: Public properties
    
    var presenter: PointsListPresenterProtocol!
    var router: PointsListRouterProtocol!
    
    // MARK: - Private properties
    
    private let dbService: DBServiceProtocol
    private let points: [MapPoint]
    
    // MARK: - Initializer
    
    init(points: [MapPoint], dbService: DBServiceProtocol) {
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
