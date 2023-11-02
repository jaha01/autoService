//
//  RegisterPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class RegistrationPresenter {
    
    weak var viewController: RegistrationViewController!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
}
