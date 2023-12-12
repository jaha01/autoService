//
//  PointsListBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation
import UIKit

final class PointsListBuilder {
    func build(points: [MapPoint], delegate: PointsListViewControllerDelegate) -> UIViewController {
        let controller = PointsListViewController()
        let interactor = PointsListInteractor(dbService: DI.shared.dbService())
        let presenter = PointsListPresenter()
        let router = PointsListRouter()
        
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.controller = controller
        interactor.router = router
        router.controller = controller
        controller.delegate = delegate
        controller.showPoints(list: points)
        
        return controller
    }
}
