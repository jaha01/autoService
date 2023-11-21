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
    
    let authService: AuthService
    let dbService: DBService
    
    init(authService: AuthService,
         dbService: DBService) {
        self.authService = authService
        self.dbService = dbService
    }
    
    
    func onViewDidLoad() {
        dbService.setupProfileInfoListeners { info in
            let ProfileDetails =
            ProfileInfoNew.init(email: info["email"] as! String, phone: info["phone"] as! String, name: info["name"] as! String, city: info["city"] as! String, experience: info["experience"] as! String, bday: info["bday"] as! String, brand: info["brand"] as! String, model: info["model"] as! String, year: info["year"] as! String, volume: info["volume"] as! String, mileage: info["mileage"] as! String)

            self.presenter.prepareToShowProfileData(ProfileDetails)
        }

    }
    
    func goToCarsModel() {
        router.goToCarsModel()
    }
    
    func updatePofileInfo(info: ProfileInfoNew) {
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
