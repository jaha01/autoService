//
//  ForgotPasswordPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ForgotPasswordPresenter {
    
    weak var viewController: ForgotPasswordViewController!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
    
    func showPasswordResetInfo(title: String, message: String) {
        viewController.showSuccessAlert(config: AlertConfig(title: title, message: message))
    }
}
