//
//  AuthTextField.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import UIKit

class AuthTextField: UITextField {
    
    enum AuthTextFieldType {
        case username
        case email
        case password
    }
    
    private let authFieldType: AuthTextFieldType
    
    init(filedType: AuthTextFieldType) {
        authFieldType = filedType
        super.init(frame: .zero)
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.size.height))
        
        switch filedType {
        case .username:
            placeholder = "Username"
        case .email:
            placeholder = "Email Address"
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = "Password"
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
