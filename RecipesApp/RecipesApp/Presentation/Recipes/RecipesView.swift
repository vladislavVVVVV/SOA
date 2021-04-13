//
//  RecipesView.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import SnapKit
import UIKit

final class RecipesViewController: UIViewController {
    let recipesViewModel: RecipesViewModel
    
    // All dimensions of the screen.
    private enum Dimensions {
        static let cellHeight: CGFloat = 68
    }
    
    // The activity indicator depending on the selected action on the screen.
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier())
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    // The object View Model which comes to the init.
    required init(_ recipesViewModel: RecipesViewModel) {
        self.recipesViewModel = recipesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get object of AppTabBarController.
        setupLargeNavigationBarWith(title: "Recipes")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        addSubviews()
        setupConstraints()
        setupRefreshControl()
        tableView.delegate = self
        tableView.dataSource = self
        getRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Show menu options when the screen opens.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshBinItems), for: .valueChanged)
        refreshControl.tintColor = UIColor.Base.accentText
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshBinItems(_ sender: AnyObject) {
        // Refresh items
        getRecipes()
        refreshControl.endRefreshing()
    }
    
    @objc private func addNewItem() {
        let viewModel = appContainer.prepareCreateEditRecipeViewModel(state: .create)
        navigationController?.pushViewController(CreateEditRecipeViewController(viewModel), animated: true)
    }
    
    @objc private func logout() {
        recipesViewModel.logout {
            tabBarController?.dismiss(animated: true, completion: nil)
        }
    }

    private func getRecipes() {
        recipesViewModel.getRecipes { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        } failure: { (error) in
            print(error.localizedDescription)
        }
    }

    private func setupDeleteAction(handler: (() -> Void)?) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: nil, handler: { _, _, _ in
            handler?()
        })
        deleteAction.backgroundColor = .red
        deleteAction.title = "Delete"
        return deleteAction
    }
    
    private func deleteRecipes(id: Int, indexPaths: [IndexPath]) {
        recipesViewModel.deleteRecipe(id: id) { [weak self] in
            guard let self = self else { return }
            self.recipesViewModel.recepies.remove(at: indexPaths[0].row)
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
        } failure: { (error) in
            print(error)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesViewModel.recepies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier()) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipe = recipesViewModel.recepies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = RecipeViewController(appContainer.prepareRecipeViewModel(recipe: recipesViewModel.recepies[indexPath.row]))
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Setup trailing swipes.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath ) -> UISwipeActionsConfiguration? {
        let deleteAction = setupDeleteAction { [weak self] in
            guard let self = self else { return }
            guard let id = self.recipesViewModel.recepies[indexPath.row].recipeId else {
                return
            }
            self.deleteRecipes(id: id, indexPaths: [indexPath])
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension RecipesViewController: CreateEditIngridientDelegate {
    func update() {
        getRecipes()
    }
}
