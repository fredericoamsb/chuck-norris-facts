//
//  SceneDelegate.swift
//  App
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import DI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        let dependencyInjector = DependencyInjector(navigationController: UINavigationController())
        dependencyInjector.build(completion: { appCoordinator in
            window?.makeKeyAndVisible()
            window?.windowScene = windowScene
            window?.rootViewController = appCoordinator.navigationController
            appCoordinator.start()
        })
    }
}
