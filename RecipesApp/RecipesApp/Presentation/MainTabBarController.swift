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
        //tabBar.tintColor = .clear
        setupTabBar()
    }
    
    private func setupTabBar() {
        var tabBarList = [UIViewController]()
        let ingridientViewController = IngridientsViewController(appContainer.prepareIngridientsViewModel())
        let ingridientNavigationViewController = UINavigationController(rootViewController: ingridientViewController)
        ingridientViewController.tabBarItem = prepareTabBarItemWith(title: "Ingridients")
        tabBarList.append(ingridientNavigationViewController)
        viewControllers = tabBarList
        selectedIndex = 0
    }
    
    private func prepareTabBarItemWith(title: String) -> UITabBarItem {
        return UITabBarItem(title: title,
                            image: UIImage(named: "ingredients")?.withRenderingMode(.alwaysOriginal),
                            selectedImage: UIImage(named: "ingredients-selected")?.withRenderingMode(.alwaysOriginal))
    }
}

