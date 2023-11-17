//
//  ProfileRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 01.11.2023.
//

import UIKit

final class ProfileRouter {
    weak var viewController: UIViewController!
    
    func goToLogin() {
        let login: UIViewController = LoginBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = login
    }
    
    func goToCarsModel() {
        let vc = CarsModelBuilder().build()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

}
