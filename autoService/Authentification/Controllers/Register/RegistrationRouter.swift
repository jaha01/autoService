//
//  RegistrationRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

final class RegistrationRouter {
    var viewController: UIViewController!
    
    func goToMain() {
        let mainController: UIViewController = MainTabBabViewController()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
}
