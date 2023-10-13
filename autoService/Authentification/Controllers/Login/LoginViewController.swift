//
//  LoginViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import Foundation

import UIKit

final class LoginViewController: UIViewController {

    var interactor: LoginInteractor!
    
    // MARK: - Private properties
    private let headerView = AuthHeaderView(title: "Sign in", subTitle: "Sign in to your account")
    private let emailField = AuthTextField(filedType: .email)
    private let passwordField = AuthTextField(filedType: .password)
    
    private let signInButton = AuthButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private let newUserButton = AuthButton(title: "New User? Create Account", fontSize: .med)
    private let forgotPasswordButton = AuthButton(title: "Forgot Password?", fontSize: .small)
    
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(newUserButton)
        view.addSubview(forgotPasswordButton)
        setupConstraints()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPass), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func showErrorAlert(alertRequest: AlertConfig) {
        AlertManager.showAlert(title: alertRequest.title, message: alertRequest.message)
    }
    
    func present() { // все такие present уйдут в router
        let window = UIApplication
                                .shared
                                .connectedScenes
                                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                .last
        window?.rootViewController = MainTabBabViewController()
        
    }
    
    // MARK: Private methods
    
    @objc private func didTapSignIn() {

        let loginRequest = LoginUserCredentials(email: self.emailField.text ?? "",
                                            password: self.passwordField.text ?? "")
        
        if !Validator.isValidEmail(for: loginRequest.email) {
            emailField.animateError()
        }
        
        if !Validator.isPasswordValid(for: loginRequest.password) {
            passwordField.animateError()
            return
        }

        interactor.signIn(loginRequest: loginRequest)
    }

    @objc private func didTapNewUser() {
        let vc = RegistrationBuilder().build()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPass() {
        let vc = ForgotPasswordBuilder().build()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 222),
            
            emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            signInButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 11),
            newUserButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            newUserButton.heightAnchor.constraint(equalToConstant: 44),
            newUserButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            newUserButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor)
        ])
    }
}


