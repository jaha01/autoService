//
//  JournalBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class JournalBuilder {
    func build() -> UIViewController {
        let controller = JournalViewController()
        let interactor = JournalInteractor(authService: DI.shared.authService)
        let presenter = JournalPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
