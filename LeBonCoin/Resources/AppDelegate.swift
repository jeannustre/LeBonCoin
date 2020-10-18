//
//  AppDelegate.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

/// The application delegate.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// Reference to the main window. Only used before iOS 13.
    var window: UIWindow?
    
    ///  Called when the application has finished launching - sets up the first module.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if #available(iOS 13.0, *) {
            // Look into SceneDelegate.swift for the Scene-based init
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = NavigationRouter.createModule()
            self.window?.makeKeyAndVisible()
        }
        
        UIView.appearance().tintColor = NamedColors.leBonAccent
        UINavigationBar.appearance().barTintColor = NamedColors.leBonBackground
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    /// Returns the default configuration when connecting to a `Scene`.
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}

