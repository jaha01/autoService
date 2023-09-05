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

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        print("viewWillAppear")
//        if Core.shared.isNewUser(){
//            // onboarding
//            print("onboarding")
//            let vc = OnboardingViewController()
//            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            self.present(vc, animated: true, completion: nil)
//        }
//        
//        if FirebaseAuth.Auth.auth().currentUser == nil {
//            print("auth")
//            let vc = AuthViewController()
//            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewWillAppear")
        if Core.shared.isNewUser(){
            // onboarding
            print("onboarding")
            let vc = OnboardingViewController()
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
        }
        
        print("viewDidAppear")
        if FirebaseAuth.Auth.auth().currentUser == nil {
            print("auth")
            let vc = AuthViewController()
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
        }
    }
    
//    override func viewWillLayoutSubviews(){
//        super.viewWillLayoutSubviews()
//        print("viewWillLayoutSubviews")
//        if Core.shared.isNewUser(){
//            // onboarding
//            let vc = OnboardingViewController()
//            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
   
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        print("currentUser = \(FirebaseAuth.Auth.auth().currentUser)")
//        if FirebaseAuth.Auth.auth().currentUser == nil {
//            print("auth")
//            let vc = AuthViewController()
//            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            self.present(vc, animated: true, completion: nil)
//        }
//
//    }
    
    private func setupUpTabs() {
        
//        let journalVC = JournalViewController()
//        let mapVC = MapViewController()
//        let profileVC = ProfileViewController()
//
//        journalVC.navigationItem.largeTitleDisplayMode = .automatic
//        mapVC.navigationItem.largeTitleDisplayMode = .automatic
//        profileVC.navigationItem.largeTitleDisplayMode = .automatic
//        //map
        
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


class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
