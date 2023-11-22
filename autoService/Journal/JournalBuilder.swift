//
//  JournalBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import UIKit

final class JournalBuilder {
    
    func build() -> UIViewController {
        let controller = JournalViewController()
        let interactor = JounalInteractor(authService: DI.shared.authService, dbService: DI.shared.dbService())
        let presenter = JournalPresenter()
        let router = JournalRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}
