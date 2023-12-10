//
//  PointsListBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 10.12.2023.
//

import Foundation
import UIKit

final class PointsListBuilder {
    func build(delegate: PointsListViewControllerDelegate) -> UIViewController {
        let controller = PointsListViewController()
        let interactor = PointsListInteractor(dbService: DI.shared.dbService())
        let presenter = PointsListPresenter()
        
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.controller = controller
        controller.delegate = delegate
        
        return controller
    }
}
