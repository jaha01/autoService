//
//  ViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 23.08.2023.
//

import UIKit
import FirebaseAuth

final class AuthViewController: UIViewController {
    
    var interactor: AuthInteactor!
    
    static let shared = AuthViewController()
    
    // MARK:  - Private Properties
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.autocapitalizationType = .none
        emailField.layer.borderWidth = 1
        emailField.backgroundColor = .white
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Пароль"
        passwordField.layer.borderWidth = 1
        passwordField.backgroundColor = .white
        passwordField.isSecureTextEntry = true
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.leftViewMode = .always
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        return passwordField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(button)
        
        interactor.onViewDidLoad()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        //isCurrentUser()
        if interactor.authentification().currentUser != nil {
            label.isHidden = true
            emailField.isHidden = true
            passwordField.isHidden = true
            button.isHidden = true

            view.addSubview(signOutButton)
            signOutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 52)
            signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }
    }
    
    func showAuthViewController() {
        
    }
    
//    func isCurrentUser() {
//        if FirebaseAuth.Auth.auth().currentUser != nil {
//            label.isHidden = true
//            emailField.isHidden = true
//            passwordField.isHidden = true
//            button.isHidden = true
//
//        }
//    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        emailField.frame = CGRect(x: 20,
                                  y: label.frame.origin.y + label.frame.size.height+10,
                                  width: view.frame.size.width - 40,
                                  height: 50)
        passwordField.frame = CGRect(x: 20,
                                     y: emailField.frame.origin.y + emailField.frame.size.height+10,
                                     width: view.frame.size.width - 40,
                                     height: 50)
        button.frame = CGRect(x: 20,
                              y: passwordField.frame.origin.y + passwordField.frame.size.height+30,
                              width: view.frame.size.width-40,
                              height: 52)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if interactor.authentification().currentUser == nil {
            emailField.becomeFirstResponder()
        }
    }
    
    // MARK: - Private methods
    @objc private func logOutTapped() {
        do {
            try interactor.authentification().signOut()
            label.isHidden = false
            emailField.isHidden = false
            passwordField.isHidden = false
            button.isHidden = false
            
            signOutButton.removeFromSuperview()
        }
        catch {
            print("Ошибка при выходе")
        }
    }
    
    @objc private func didTapButton() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
                  print("Пустой логин или пароль")
                  return
              }
        // Get Auth instance
        // attempt sign in
        // if failure present alert to create account
        // if user continue, create account
        
        // check sign in on app launch
        // allow user to sign out with button
        
        interactor.authentification().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else {
                return
            }
            guard error == nil else {
                // show acount creation
                self.showCreateAccount(email, password)
                return
            }
            print("Вы вошли")
//            self.label.isHidden = true
//            self.emailField.isHidden = true
//            self.passwordField.isHidden = true
//            self.button.isHidden = true
            
            self.emailField.resignFirstResponder()
            self.passwordField.resignFirstResponder()
            
            let vc = MainTabBabViewController()
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    private func showCreateAccount(_ email: String, _ password: String) {
        let alert = UIAlertController(title: "Создать аккаунт",
                                      message: "Хотите создать аккаунт?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: { _ in
            self.interactor.authentification().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else {
                    return
                }
                guard error == nil else {
                    // show acount creation
                    print("ошибка создания аккаунта")
                    return
                }
                print("Вход осуществлен")
                self.label.isHidden = true
                self.emailField.isHidden = true
                self.passwordField.isHidden = true
                self.button.isHidden = true
                
                self.emailField.resignFirstResponder()
                self.passwordField.resignFirstResponder()
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true)
    }

}
