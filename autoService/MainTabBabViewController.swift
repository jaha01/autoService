//
//  ViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 26.08.2023.
//

import UIKit
import FirebaseAuth

class MainTabBabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupUpTabs()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        print("viewWillAppear")
//        if SetupService.shared.isNewUser(){
//            // onboarding
//            print("onboarding")
//            let vc = OnboardingViewController()
//            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            self.present(vc, animated: true, completion: nil)
//        }
//        
//        print("viewDidAppear")
//        if FirebaseAuth.Auth.auth().currentUser == nil {
//            print("auth")
//            let vc = AuthViewController()
//            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            self.present(vc, animated: true, completion: nil)
//        }
    }
    
    
    private func setupUpTabs() {
        
        let controllers = [JournalViewController(), MapViewController(), ProfileViewController()]
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
        
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = false
        }
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }
    
}

