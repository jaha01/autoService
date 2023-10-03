//
//  ViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 23.08.2023.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        view.addSubview(label)
        setupConstraints()
        
        AuthentificationService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showError(title: "Error fetching user", message: "\(error.localizedDescription)")
                return
            }
            
            if let user = user {
                self.label.text = "\(user.username)\n\(user.email)"
            }
        }
    }
    
    // MARK: - Private methods
    @objc private func didTapLogout() {
        AuthentificationService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showError(title: "Unknown Signin in Error", message: "\(error.localizedDescription)")
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentification()
            }
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

