//
//  ViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 23.08.2023.
//

import UIKit
import FirebaseAuth

final class AuthViewController: UIViewController {
    
    var interactor: AuthInteractor!
    
    // MARK: - Properties
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
        
//        interactor.onViewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        view.addSubview(label)
        setupConstraints()
        
//        self.label.text =  interactor.getUserShortInfo()
        
    }

    func changeViewController(vc: UIViewController) {
        let window = UIApplication.shared.windows.last { $0.isKeyWindow }
        // let builder...
        window?.rootViewController = vc
    }
    
    func showErrorAlert(title: String, message: String?) {
        AlertManager.showAlert(title: title, message: message)
    }
    
    
    // MARK: - Private methods
    @objc private func didTapLogout() {
        interactor.userSignOut()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

// 
