//
//  ProfilePresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfilePresenter {
    
    weak var viewController: ProfileViewController!
    
    func showError(alertRequest: AlertRequest) {
        viewController.showErrorAlert(alertRequest: alertRequest)
    }
    
    func didTapSignOut() {
        viewController.present()
    }
}
