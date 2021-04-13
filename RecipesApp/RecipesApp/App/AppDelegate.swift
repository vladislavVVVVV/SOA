//
//  AppDelegate.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let appContainer = AppContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let login = LoginViewController(appContainer.prepareLoginViewModel())
        let nav = UINavigationController(rootViewController: login)
        let rootViewController = nav
        window?.rootViewController = rootViewController
        return true
    }
}

