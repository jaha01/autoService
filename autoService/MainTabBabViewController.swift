//
//  ViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 26.08.2023.
//

import UIKit
import FirebaseAuth

class MainTabBabViewController: UITabBarController {

    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUpTabs()

    }

    // MARK: - Private methods
    
    private func setupUpTabs() {
        
        let controllers = [JournalBuilder().build(), MapViewController(), ProfileBuilder().build()]
        let navControllers: [UINavigationController] = controllers.map {
            let navController = UINavigationController(rootViewController: $0)
            navController.navigationBar.prefersLargeTitles = false
            return navController
        }
        
        let nav1 = UINavigationController(rootViewController: controllers[0])
        let nav2 = UINavigationController(rootViewController: controllers[1])
        let nav3 = UINavigationController(rootViewController: controllers[2])

        
        nav1.tabBarItem = UITabBarItem(title: "Журнал", image: UIImage(systemName: "book"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Карты", image: UIImage(systemName: "map"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 3)
        
       /*
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = false
        }
        */
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }
    
}

