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
    
    public static func showAlert(config: AlertConfig, completion:  (() -> ())? = nil) {
        let topController = UIApplication.shared.getTopViewController()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dissmiss", style: .default, handler: { action in
                completion?()
            }))
            topController.present(alert, animated: true)
        }
    }
    
    public static func addJournalItemAlert(completion: @escaping(String) -> Void) {
        let topController = UIApplication.shared.getTopViewController()
        let alert = UIAlertController(title: "Добавить", message: "Добавьте новую запись", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Введите запись"
        }
        alert.addAction(UIAlertAction(title: "Готово", style: .default, handler: { action in
            if let field = alert.textFields?.first, let text = field.text, !text.isEmpty {
                completion(text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        topController.present(alert, animated: true)
    }
    
    public static func showMapTapInfo(config: AlertMapPoint, completion:  @escaping(PointTitle) -> Void) {
        let topController = UIApplication.shared.getTopViewController()
        var name: UITextField?
        var description: UITextField?
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: config.title, message: "", preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.placeholder = "Введите название"
                name = textField
            }
            alert.addTextField { textField in
                textField.placeholder = "Введите описание"
                description = textField
            }
            alert.addTextField { latitude in
                latitude.text = String(config.point.latitude)
                latitude.isEnabled = false
            }
            alert.addTextField { longitude in
                longitude.text = String(config.point.longitude)
                longitude.isEnabled = false
            }
            
            alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { action in
                completion(PointTitle(name: (name?.text)!, description: (description?.text)!))
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: .destructive, handler: nil))
            
            topController.present(alert, animated: true)
        }
    }
}
