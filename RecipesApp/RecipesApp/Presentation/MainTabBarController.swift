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
        setupTabBar()
    }
    
    private func setupTabBar() {
        var tabBarList = [UIViewController]()
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        vc.tabBarItem = prepareTabBarItemWith()
        tabBarList.append(vc)
        viewControllers = tabBarList
        selectedIndex = 0
    }
    
    private func prepareTabBarItemWith() -> UITabBarItem {
        return UITabBarItem(title: "Ingridients",
                            image: UIImage(),
                            selectedImage: UIImage())
    }
}

