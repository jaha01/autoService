//
//  ForgotPasswordPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ForgotPasswordPresenter {
    
    weak var viewController: ForgotPasswordViewController!
    
    func showError(alertRequest: AlertRequest) {
        viewController.showErrorAlert(alertRequest: alertRequest)
    }
    
    func showSuccess(alertRequest: AlertRequest) {
        viewController.showSuccessAlert(alertRequest: alertRequest)
    }
}
