//
//  AlertManager.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import Foundation
import UIKit

struct AlertConfig {
    var title: String
    var message: String?
}

class AlertManager {
    
    public static func showAlert(title: String, message: String?) {
        let topController = UIApplication.shared.getTopViewController()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dissmiss", style: .default, handler: nil))
            topController.present(alert, animated: true)
        }
    }
}
