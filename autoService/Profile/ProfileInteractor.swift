//
//  ProfileInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfileInteractor {
    
    // MARK: - Public properties
    
    var presenter: ProfilePresenter!
    var router: ProfileRouter!
    
    // MARK: - Private properties
    
    private let authService: AuthService
    private let dbService: DBService
    
    // MARK: - Initializer
    
    init(authService: AuthService,
         dbService: DBService) {
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
        router.listCarsBrand()
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
