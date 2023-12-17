//
//  LoginPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.10.2023.
//

import Foundation
import UIKit

protocol LoginPresenterProtocol {
    func showError(config: AlertConfig)
}

final class LoginPresenter: LoginPresenterProtocol {
    weak var viewController: LoginViewControllerProtocol!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
}
