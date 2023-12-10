//
//  AppDelegate.swift
//  autoService
//
//  Created by Jahongir Anvarov on 23.08.2023.
//

import UIKit
import Firebase
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        var apiKey: String {
          get {
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
              fatalError("Couldn't find file 'Info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "YMKMAPKIT_API_KEY") as? String else {
              fatalError("Couldn't find key 'YMKMAPKIT_API_KEY' in 'Info.plist'.")
            }
            return value
          }
        }
        YMKMapKit.setApiKey(apiKey)
        YMKMapKit.sharedInstance().onStart()
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

