//
//  ProfileInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfileInteractor {
    
    var presenter: ProfilePresenter!
    var router: ProfileRouter!
    // MARK: - Private properties
    private let authService: AuthService
    private let dbService: DBService
    
    init(authService: AuthService,
         dbService: DBService) {
        self.authService = authService
        self.dbService = dbService
    }
    
    // MARK: - Public methods
    func onViewDidLoad() {
        dbService.setupProfileInfoListeners { profileInfo in
            self.presenter.prepareToShowProfileData(profileInfo)
        }
    }
    
    func goToCarsModel() {
        router.goToCarsModel()
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
