//
//  ProfileRouter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 01.11.2023.
//

import UIKit

final class ProfileRouter {
    
    // MARK: - Public properties
    
    weak var viewController: UIViewController!
   
    // MARK: - Public methods
    
    func goToLogin() {
        let login: UIViewController = LoginBuilder().build()
        let window = viewController.view.window
        window?.rootViewController = login
    }
    
    func listCarsBrand() {
        let tableVC = CarsModelBuilder().build()
        let nav = UINavigationController(rootViewController: tableVC)
        nav.navigationBar.backgroundColor = .white
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 25
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }        
        viewController.present(nav, animated: true, completion: nil)
    }

}
