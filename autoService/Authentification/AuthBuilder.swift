//
//  AuthBuilder.swift
//  autoService
//
//  Created by Jahongir Anvarov on 27.09.2023.
//

import Foundation
import UIKit

final class AuthBuilder {
    
    func build() -> UIViewController {
        let controller = AuthViewController()
        let interactor = AuthInteactor(authService: DI.shared.authService)
        let presenter = AuthPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.authViewController = controller
        
        return controller
    
    }
}
