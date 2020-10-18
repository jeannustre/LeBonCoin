//
//  SceneDelegate.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

/// The scene delegate, used in place of the AppDelegate for the programmatic entry point for iOS 13+.
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// The window for the current scene.
    var window: UIWindow?

    /// When a Scene is aboutto connect to a session, initializes the first module.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = NavigationRouter.createModule()
        window?.makeKeyAndVisible()
        
        UIView.appearance().tintColor = NamedColors.leBonAccent
        UINavigationBar.appearance().barTintColor = NamedColors.leBonBackground
    }

}

