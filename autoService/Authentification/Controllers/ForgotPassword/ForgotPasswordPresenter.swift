//
//  ForgotPasswordPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

protocol ForgotPasswordPresenterProtocol {
    func showError(config: AlertConfig)
    func showPasswordResetInfo(title: String, message: String)
}

final class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    
    weak var viewController: ForgotPasswordViewController!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
    
    func showPasswordResetInfo(title: String, message: String) {
        viewController.showSuccessAlert(config: AlertConfig(title: title, message: message))
    }
}
