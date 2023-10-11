//
//  ProfileViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 29.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    var interactor: ProfileInteractor!
    
    // MARK: - Public method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
    }

    
    func present() {
        let window = UIApplication
                                .shared
                                .connectedScenes
                                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                .last  
        window?.rootViewController = LoginBuilder().build()
    }
    
    func showErrorAlert(alertRequest: AlertRequest) {
        AlertManager.showAlert(title: alertRequest.title, message: alertRequest.message)
    }
    
    // MARK: - Private methods
    @objc private func didTapLogout() {
        interactor.userSignOut()
    }
}
