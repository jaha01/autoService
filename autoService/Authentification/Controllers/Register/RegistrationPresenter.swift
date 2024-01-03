//
//  RegisterPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

protocol RegistrationPresenterProtocol {
    func showError(config: AlertConfig)
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    weak var viewController: RegistrationViewControllerProtocol!
    
    // MARK: - Public methods
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
}
