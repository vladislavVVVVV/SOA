//
//  MainTabBarController.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor.Base.accent
        setupTabBar()
    }
    
    private func setupTabBar() {
        var tabBarList = [UIViewController]()

        let ingridientViewController = IngridientsViewController(appContainer.prepareIngridientsViewModel())
        let ingridientNavigationViewController = UINavigationController(rootViewController: ingridientViewController)
        ingridientViewController.tabBarItem = prepareTabBarItemWith(title: "Ingridients", iconName: "ingredients", iconSelectedName: "ingredients-selected")
        tabBarList.append(ingridientNavigationViewController)
        
        let menuesViewController = MenuesViewController(appContainer.prepareMenuesViewModel())
        let menuesNavigationViewController = UINavigationController(rootViewController: menuesViewController)
        menuesViewController.tabBarItem = prepareTabBarItemWith(title: "Menues", iconName: "menu", iconSelectedName: "menu-selected")
        tabBarList.append(menuesNavigationViewController)
        
        viewControllers = tabBarList
        selectedIndex = 0
    }
    
    private func prepareTabBarItemWith(title: String, iconName: String, iconSelectedName: String) -> UITabBarItem {
        return UITabBarItem(title: title,
                            image: UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal),
                            selectedImage: UIImage(named: iconSelectedName)?.withRenderingMode(.alwaysOriginal))
    }
}

