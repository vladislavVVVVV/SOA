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
        let rootViewController = appContainer.prepareNewsTabBarController()
        window?.rootViewController = rootViewController
        return true
    }
}

