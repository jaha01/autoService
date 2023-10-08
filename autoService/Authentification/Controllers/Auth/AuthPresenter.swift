//
//  AuthPresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import UIKit

final class AuthPresenter {
    
    weak var viewController: AuthViewController!
    
    func showError(title: String, message: String?) {
        viewController.showErrorAlert(title: title, message: message)
    }
    
    // case success showSuccess
    
    func presentViewController(vc: UIViewController) {
        viewController.changeViewController(vc: vc)
    }
    
}
