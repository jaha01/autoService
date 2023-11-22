//
//  ProfilePresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfilePresenter {
    
    weak var viewController: ProfileViewController!
    // MARK: - Public methods
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
    
    func prepareToShowProfileData(_ items: ProfileInfo) {
        viewController.setProfileData(item: items)
    }
}

