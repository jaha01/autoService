//
//  AppDelegate.swift
//  autoService
//
//  Created by Jahongir Anvarov on 23.08.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension UIApplication {
    

    func getTopViewController(base: UIViewController? = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last?.rootViewController) -> UIViewController? {

   if let nav = base as? UINavigationController {
       return getTopViewController(base: nav.visibleViewController)

   } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
       return getTopViewController(base: selected)

   } else if let presented = base?.presentedViewController {
       return getTopViewController(base: presented)
   }
   return base
    }
}
