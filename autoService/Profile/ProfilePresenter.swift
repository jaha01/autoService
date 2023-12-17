//
//  ProfilePresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

protocol ProfilePresenterProtocol {
    func showError(config: AlertConfig)
    func prepareToShowProfileData(_ items: ProfileInfo)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Public properties
    
    weak var viewController: ProfileViewControllerProtocol!
    
    // MARK: - Public methods
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
    
    func prepareToShowProfileData(_ items: ProfileInfo) {
        viewController.setProfileData(item: items)
    }
}

