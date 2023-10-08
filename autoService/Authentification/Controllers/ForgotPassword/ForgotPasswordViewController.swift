//
//  ForgotPasswordViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {
    
    var interactor: ForgotPasswordInteractor!
    
    //MARK: - Properties
    private let headerView = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailField = AuthTextField(filedType: .email)
    private let resetPasswordButton = AuthButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(resetPasswordButton)
        
        setupConstraints()
        resetPasswordButton.addTarget(self, action: #selector(didTapForgotPass), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func showErrorAlert(alertRequest: AlertRequest) {
        AlertManager.showAlert(title: alertRequest.title, message: alertRequest.message)
    }
    
    func showSuccessAlert(alertRequest: AlertRequest) {
        AlertManager.showAlert(title: alertRequest.title, message: alertRequest.message)
    }
    
    // MARK: - Private methods
    @objc private func didTapForgotPass(){
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            emailField.textColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.emailField.textColor = .black
            }
            return
        }
        
        interactor.forgotPassword(email: email)
    }
    
    private func setupConstraints() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 230),
            
            emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 11),
            emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            resetPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            resetPasswordButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
        ])
        
    }
    
}
