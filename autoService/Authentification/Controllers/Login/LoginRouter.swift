//
//  LoginRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.10.2023.
//

import UIKit

final class LoginRouter {
    var viewcontroller: UIViewController!
    
    func goToMain() {
        let mainController: UIViewController = MainTabBabViewController()
        let window = viewcontroller.view.window
        window?.rootViewController = mainController
    }
}
