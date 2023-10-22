//
//  JournalBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 22.10.2023.
//

import Foundation
import UIKit

final class JournalBuilder {
    
    func build() -> UIViewController {
        let controller = JournalViewController()
        let interactor = JounalInteractor(authService: DI.shared.authService, dbService: DI.shared.dbService())
        let presenter = JournalPresenter()
        
        controller.interactor = interactor
        presenter.viewController = controller
        interactor.presenter = presenter
        
        return controller
    }
}
