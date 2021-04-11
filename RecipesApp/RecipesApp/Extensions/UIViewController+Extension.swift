//
//  UIViewController+Extension.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit
import SnapKit

// MARK: - AppContainer object
extension UIViewController {
    var appContainer: AppContainer {
        get {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                print("Failure to get the AppContainer object.")
                return AppContainer()
            }
            return delegate.appContainer
        }
    }
}

// MARK: - Preparing NavigationBar
extension UIViewController {
    func setupBaseNavigationBarWith(title: String) {
        view.backgroundColor = UIColor.Base.background
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.Base.accentText]
        navBarAppearance.backgroundColor = UIColor.Base.accent
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor.Base.accentText
        navigationItem.title = title
    }
    
    func setupLargeNavigationBarWith(title: String) {
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = UIColor.Base.background
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.Base.accentText]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Base.accentText]
        navBarAppearance.backgroundColor = UIColor.Base.accent
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor.Base.accentText
                
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = title
    }
}

// MARK: - Preparing Alerts
extension UIViewController {
    func showDefaultErrorAlert() {
        let alert = UIAlertController(title: "An error occurred in the application. Try again",
                                      message: "Internet is unreachable. Please check your Internet connection",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
