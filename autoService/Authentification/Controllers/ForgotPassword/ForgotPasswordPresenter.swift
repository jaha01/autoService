//
//  ForgotPasswordPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ForgotPasswordPresenter {
    
    weak var viewController: ForgotPasswordViewController!
    
    func showError(alertRequest: AlertConfig) {
        viewController.showErrorAlert(alertRequest: alertRequest)
    }
    
    func showSuccess(alertRequest: AlertConfig) {
        viewController.showSuccessAlert(alertRequest: alertRequest)
    }
}