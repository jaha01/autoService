//
//  ForgotPasswordRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 18.10.2023.
//

import UIKit

final class ForgotPasswordRouter {
    weak var viewController: UIViewController!
    
    private let loginBuilder: LoginBuilderProtocol
    
    init(loginBuilder: LoginBuilderProtocol) {
        self.loginBuilder = loginBuilder
    }
    
    func goToLogin() {
        let mainController: UIViewController = loginBuilder.build()
        let window = viewController.view.window
        window?.rootViewController = mainController
    }
}
