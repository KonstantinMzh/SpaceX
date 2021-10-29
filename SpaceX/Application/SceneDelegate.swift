//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Константин Маламуж on 21.10.2021.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let factory = ScreenFactory()
        window?.windowScene = scene
        window?.rootViewController = factory.createRocketsScreen()
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }

}

