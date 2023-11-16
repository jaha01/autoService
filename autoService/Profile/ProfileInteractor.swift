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
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    private let ProfileDetails = [
        
            ProfileInfo.init(section: "Owner Info", item: [
                Object.init(name: "", placeholder: "Почта"),
                Object.init(name: "", placeholder: "Телефон"),
                Object.init(name: "", placeholder: "Имя"),
                Object.init(name: "", placeholder: "Город"),
                Object.init(name: "", placeholder: "Стаж"),
                Object.init(name: "", placeholder: "Дата Рождения")
            ]),
            ProfileInfo.init(section: "Car Info", item: [
                Object.init(name: "", placeholder: "Марка"),
                Object.init(name: "", placeholder: "Модель"),
                Object.init(name: "", placeholder: "Год выпуска"),
                Object.init(name: "", placeholder: "Объем"),
                Object.init(name: "", placeholder: "Пробег")
            ])
        ]
    
    
    func onViewDidLoad() {
        presenter.prepareToShowProfileData(ProfileDetails)
        
    }
    
    func carsList(navController: UINavigationController?) {
        let vc = CarsModelViewController()
        navController?.pushViewController(vc, animated: true)
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
