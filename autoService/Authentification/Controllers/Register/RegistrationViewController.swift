//
//  RegisterViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    var interactor: RegistrationInteractor!
    
    // MARK: - Private properties
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    private let usernameField = AuthTextField(filedType: .username)
    private let emailField = AuthTextField(filedType: .email)
    private let passwordField = AuthTextField(filedType: .password)
    
    private let signUpButton = AuthButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    private let signInButton = AuthButton(title: "Already have an account? Sign In", fontSize: .med)
    
    private let termsTextView: UITextView = {
        
        let attributedString = NSMutableAttributedString(string: "you agree with our terms & conditions and read privacy policy")
        attributedString.addAttribute(.link, value: "terms://terms&conditions", range: (attributedString.string as NSString).range(of: "terms & conditions"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "privacy policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .label
        tv.textAlignment = .center
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(emailField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(termsTextView)
        termsTextView.delegate = self
        
        setupConstraints()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func showErrorAlert(alertRequest: AlertConfig) {
        AlertManager.showAlert(title: alertRequest.title, message: alertRequest.message)
    }
    
    func present() {
        let window = UIApplication
                                .shared
                                .connectedScenes
                                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                .last  
        window?.rootViewController = MainTabBabViewController()
    }
    
    // MARK: Private methods
    
    @objc private func didTapSignIn() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapSignUp() {
        let registerUserCredentials = RegisterUserCredentials(username: usernameField.text ?? "",
                                                      email: emailField.text ?? "",
                                                      password: passwordField.text ?? "")
        
        if !Validator.isValidUsername(for: registerUserCredentials.username) {
            usernameField.animateError()
            return
        }
        
        if !Validator.isValidEmail(for: registerUserCredentials.email) {
            emailField.animateError()
            return
        }
        
        if !Validator.isPasswordValid(for: registerUserCredentials.password) {
            passwordField.animateError()
            return
        }
        
        interactor.registerUser(registerUserCredentials: registerUserCredentials)
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 222),
            
            usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: 55),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
            emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 55),
            signUpButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 6),
            termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            termsTextView.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            termsTextView.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 11),
            signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 44),
            signInButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
        ])
    }
}

extension RegistrationViewController: UITextViewDelegate {
    // MARK: - Public methods
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            showWebViewerController(with: "https://policies.google.com/terms?hl=en-US")
        } else if URL.scheme == "privacy" {
            showWebViewerController(with: "https://policies.google.com/privacy?hl=en-US")
        }
        return true
    }
    
    // MARK: - Private methods
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}
