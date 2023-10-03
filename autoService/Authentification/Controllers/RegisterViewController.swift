//
//  RegisterViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
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
        //        tv.text = "Terms & Conditions"
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
    
    
    // MARK: Private methods
    
    @objc private func didTapSignIn() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapSignUp() {
        let registerUserRequest = RegisterUserRequest(username: usernameField.text ?? "",
                                                      email: emailField.text ?? "",
                                                      password: passwordField.text ?? "")
        
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showError(title: "Invalid User", message: "Please enter a valid User")
            return
        }
        
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showError(title: "Invalid Email", message: "Please enter a valid Email")
            return
        }
        
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showError(title: "Invalid Password", message: "Please enter a valid Password")
            return
        }
        
        AuthentificationService.shared.registerUser(with: registerUserRequest) { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showError(title: "Unknown Registration Error", message: "\(error.localizedDescription)")
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentification()
            }
        }
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
            usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
            emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 55),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 6),
            termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 11),
            signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 44),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
        ])
    }
}

extension RegisterViewController: UITextViewDelegate {
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
