//
//  SceneDelegate.swift
//  Trello
//
//  Created by Onie on 09.11.2019.
//  Copyright © 2019 Onie. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let firstNC  = RootViewController()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [firstNC]

        self.window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        
    }
}

extension SceneDelegate {
    static var shared: SceneDelegate {
        return UIApplication.shared.delegate as! SceneDelegate
    }
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}

