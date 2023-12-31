//
//  ProfileInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

protocol ProfileInteractorProtocol {
    func onViewDidLoad()
    func showCarsBrand()
    func updateProfileInfo(info: ProfileInfo)
    func didTapSignOut()
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: ProfilePresenterProtocol!
    var router: ProfileRouterProtocol!
    
    // MARK: - Private properties
    
    private let authService: AuthServiceProtocol
    private let dbService: ProfileInfoServiceProtocol
    
    // MARK: - Initializer
    
    init(authService: AuthServiceProtocol,
         dbService: ProfileInfoServiceProtocol) {
        self.authService = authService
        self.dbService = dbService
    }
    
    // MARK: - Public methods
    func onViewDidLoad() {
        dbService.setupProfileInfoListeners { [weak self] profileInfo in
            guard let self = self else { return }
            self.presenter.prepareToShowProfileData(profileInfo)
        }
    }
    
    func showCarsBrand() {
        router.showListCarsBrand()
    }
    
    func updateProfileInfo(info: ProfileInfo) {
        dbService.uploadProfileInfo(profileInfo: info)
    }
    
    func didTapSignOut() {
        
        authService.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.presenter.showError(config: AlertConfig(title: "Unknown Signin in Error", message: "\(error.localizedDescription)"))
                return
            }
            self.router.goToLogin()
        }
    }
}
