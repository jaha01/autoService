//
//  LoginPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 05.10.2023.
//

import Foundation
import UIKit

final class LoginPresenter{
    weak var viewController: LoginViewController!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
}
