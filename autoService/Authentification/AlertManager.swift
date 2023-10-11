//
//  AlertManager.swift
//  autoService
//
//  Created by Jahongir Anvarov on 03.10.2023.
//

import Foundation
import UIKit

struct AlertRequest {
    var title: String
    var message: String?
}

class AlertManager {
    
    public static func showAlert(title: String, message: String?) {
        let keyWindow = UIApplication
                                    .shared
                                    .connectedScenes
                                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                    .last  
        //        view.windowScene.keyWindow
        
        // will return tabBar or navBar instead View
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dissmiss", style: .default, handler: nil))
                topController.present(alert, animated: true)
            }
        }
    }
    
}
